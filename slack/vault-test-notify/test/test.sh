#!/usr/bin/env bash
# Tests for notify.sh. Renders payloads with dry-run across the supported inputs and
# checks them, then exercises the real delivery path against a local mock endpoint.
#
#   bash slack/vault-test-notify/test/test.sh
set -uo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
NOTIFY="$HERE/../notify.sh"
TMP="$(mktemp -d "${TMPDIR:-/tmp}/vault-test-notify.XXXXXX")" || exit 1
SERVER_PID=""
cleanup() {
  if [ -n "$SERVER_PID" ]; then
    kill "$SERVER_PID" 2>/dev/null || true
    wait "$SERVER_PID" 2>/dev/null || true
  fi
  rm -rf "$TMP"
}
trap cleanup EXIT

total=0
fails=0

check() { # name expected actual
  total=$((total + 1))
  if [ "$2" = "$3" ]; then
    printf 'ok   %s\n' "$1"
  else
    printf 'FAIL %s\n  expected: %s\n  actual:   %s\n' "$1" "$2" "$3"
    fails=$((fails + 1))
  fi
}

contains() { # name needle haystack
  total=$((total + 1))
  case "$3" in
    *"$2"*) printf 'ok   %s\n' "$1" ;;
    *) printf 'FAIL %s\n  expected to contain: %s\n  actual: %s\n' "$1" "$2" "$3"; fails=$((fails + 1)) ;;
  esac
}

lacks() { # name needle haystack
  total=$((total + 1))
  case "$3" in
    *"$2"*) printf 'FAIL %s\n  must not contain: %s\n' "$1" "$2"; fails=$((fails + 1)) ;;
    *) printf 'ok   %s\n' "$1" ;;
  esac
}

# run_notify KEY=VALUE...  runs notify.sh in a clean environment (dry-run unless the
# caller passes INPUT_DRY_RUN=false) and sets OUT, RC, PAYLOAD and TITLE.
run_notify() {
  : > "$TMP/gh_output"
  OUT="$(env -i PATH="$PATH" HOME="$TMP" TMPDIR="$TMP" GITHUB_OUTPUT="$TMP/gh_output" \
    GITHUB_SERVER_URL="https://github.com" \
    GITHUB_REPOSITORY="${REPO-LedgerHQ/vault-public-api-tests}" \
    GITHUB_WORKFLOW="Full Vault - Next Nightly" GITHUB_RUN_ID="123" \
    GITHUB_EVENT_NAME="${EVENT-schedule}" GITHUB_ACTOR="${ACTOR-octocat}" \
    INPUT_DRY_RUN="true" "$@" bash "$NOTIFY" 2>&1)"
  RC=$?
  PAYLOAD="$(sed -n 's/^payload=//p' "$TMP/gh_output")"
  TITLE="$(sed -n 's/^title=//p' "$TMP/gh_output")"
}

# attachment <jq filter>  applies the filter to the first attachment of the payload.
attachment() { printf '%s' "$PAYLOAD" | jq -r ".attachments[0] | $1"; }
field() { attachment ".fields[] | select(.title == \"$1\") | .value"; }

COUNTS="630 passed, 1 failed, 2 broken, 40 skipped, 673 total"

echo "== a legacy notification, end to end"
run_notify INPUT_ENVIRONMENT=vault-main INPUT_SUITE=API INPUT_EMOJI=:vault: INPUT_STATUS=good \
  INPUT_SUMMARY="$COUNTS" INPUT_REPORT_URL=https://allure.example/r/1 INPUT_REPORT_PATH=vault_main_api
check "title" ":large_blue_circle: [main][legacy] :vault: API Test Results :green-check:" "$TITLE"
check "title output matches the attachment title" "$TITLE" "$(attachment .title)"
check "text" "Environment: vault-main — $COUNTS" "$(attachment .text)"
check "colour" good "$(attachment .color)"
check "field order" "Allure Report,Workflow,Trigger" "$(attachment '[.fields[].title] | join(",")')"
check "report field" "<https://allure.example/r/1 | vault_main_api>" "$(field 'Allure Report')"
check "workflow field" "<https://github.com/LedgerHQ/vault-public-api-tests/actions/runs/123 | Full Vault - Next Nightly>" "$(field Workflow)"
check "trigger on a schedule" "schedule" "$(field Trigger)"
check "trigger field is full width" "false" "$(attachment '.fields[] | select(.title == "Trigger") | .short')"
check "footer" "<https://github.com/LedgerHQ/vault-public-api-tests | LedgerHQ/vault-public-api-tests>" "$(attachment .footer)"
check "no pretext" "null" "$(attachment '.pretext')"
check "exit code" 0 "$RC"

echo "== every environment"
for row in \
  "vault-main|:large_blue_circle: [main]" \
  "vault-next|:large_purple_circle: [next]" \
  "minivault|:large_orange_circle: [minivault]" \
  "vault-ppr|:black_circle: [ppr]" \
  "prd|:white_circle: [prd]" \
  "vault-qa|:argocd: [qa]" \
  "argocd|:argocd: [argocd]"; do
  env_name="${row%%|*}"
  tag="${row#*|}"
  run_notify INPUT_ENVIRONMENT="$env_name" INPUT_SUITE=API INPUT_STATUS=good
  check "environment $env_name" "${tag}[legacy] :vault: API Test Results :green-check:" "$TITLE"
done

echo "== no environment, unknown environment"
run_notify INPUT_ENVIRONMENT= INPUT_SUITE="UI Smoke" INPUT_STATUS=good INPUT_SUMMARY="10 passed, 0 failed, 0 broken, 0 skipped, 10 total"
check "no environment: title" "[legacy] :vault: UI Smoke Test Results :green-check:" "$TITLE"
check "no environment: no Environment line" "10 passed, 0 failed, 0 broken, 0 skipped, 10 total" "$(attachment .text)"
run_notify INPUT_ENVIRONMENT=staging INPUT_SUITE=API INPUT_STATUS=good
check "unknown environment: bare tag" "[staging][legacy] :vault: API Test Results :green-check:" "$TITLE"
contains "unknown environment: warns" "::warning" "$OUT"

echo "== revault: stack, qualifier, ref, environment detail, manual trigger"
REPO=LedgerHQ/revault EVENT=workflow_dispatch run_notify INPUT_ENVIRONMENT=vault-next INPUT_ENVIRONMENT_DETAIL=revaultfunds1 \
  INPUT_SUITE=Web INPUT_EMOJI=:globe_with_meridians: INPUT_QUALIFIER="ETH Pectra staking" INPUT_REF=web@3.18.3 \
  INPUT_STATUS=danger INPUT_SUMMARY="19 passed, 5 failed, 0 broken, 0 skipped, 24 total"
check "title" ":large_purple_circle: [next][revault] :globe_with_meridians: Web Test Results (ETH Pectra staking) · web@3.18.3 :x:" "$TITLE"
check "text" "Environment: vault-next / revaultfunds1 — 19 passed, 5 failed, 0 broken, 0 skipped, 24 total" "$(attachment .text)"
check "colour" danger "$(attachment .color)"
check "manual trigger links the actor" "manual · <https://github.com/octocat | octocat>" "$(field Trigger)"
check "footer links the revault repo" "<https://github.com/LedgerHQ/revault | LedgerHQ/revault>" "$(attachment .footer)"
run_notify INPUT_ENVIRONMENT=vault-main INPUT_SUITE=API INPUT_STACK=revault INPUT_STATUS=good
check "explicit stack overrides the repository" ":large_blue_circle: [main][revault] :vault: API Test Results :green-check:" "$TITLE"
run_notify INPUT_ENVIRONMENT=vault-main INPUT_SUITE=API INPUT_EMOJI= INPUT_STATUS=good
check "empty emoji leaves no double space" ":large_blue_circle: [main][legacy] API Test Results :green-check:" "$TITLE"

echo "== triggers"
EVENT=repository_dispatch run_notify INPUT_SUITE=API INPUT_STATUS=good
check "repository_dispatch" "repository_dispatch · <https://github.com/octocat | octocat>" "$(field Trigger)"
EVENT=workflow_dispatch ACTOR= run_notify INPUT_SUITE=API INPUT_STATUS=good
check "no actor" "manual" "$(field Trigger)"

echo "== counts and status from an Allure summary"
mkdir -p "$TMP/allure"
echo '{"statistic":{"passed":58,"failed":0,"broken":0,"skipped":0,"total":58}}' > "$TMP/allure/good.json"
echo '{"statistic":{"passed":57,"failed":1,"broken":0,"skipped":0,"total":58}}' > "$TMP/allure/failed.json"
echo '{"statistic":{"passed":56,"failed":0,"broken":2,"skipped":0,"total":58}}' > "$TMP/allure/broken.json"
echo '{"statistic":{"passed":0,"failed":0,"broken":0,"skipped":0,"total":0}}' > "$TMP/allure/empty.json"
echo '{"widget":"no statistic"}' > "$TMP/allure/nostat.json"
echo 'not json' > "$TMP/allure/bad.json"
run_notify INPUT_ENVIRONMENT=vault-next INPUT_SUITE=API INPUT_ALLURE_SUMMARY="$TMP/allure/good.json"
check "good: text" "Environment: vault-next — 58 passed, 0 failed, 0 broken, 0 skipped, 58 total" "$(attachment .text)"
check "good: colour" good "$(attachment .color)"
contains "good: emoji" ":green-check:" "$TITLE"
run_notify INPUT_SUITE=API INPUT_ALLURE_SUMMARY="$TMP/allure/failed.json"
check "failed: colour" danger "$(attachment .color)"
contains "failed: emoji" ":x:" "$TITLE"
run_notify INPUT_SUITE=API INPUT_ALLURE_SUMMARY="$TMP/allure/broken.json"
check "broken: colour" danger "$(attachment .color)"
run_notify INPUT_SUITE=API INPUT_ALLURE_SUMMARY="$TMP/allure/empty.json"
check "nothing ran: not green" danger "$(attachment .color)"
check "nothing ran: counts are still shown" "0 passed, 0 failed, 0 broken, 0 skipped, 0 total" "$(attachment .text)"
run_notify INPUT_SUITE=API INPUT_ALLURE_SUMMARY="$TMP/allure/nostat.json"
check "no statistic object: no results" "No test results" "$(attachment .text)"
contains "no statistic object: warns" "::warning" "$OUT"
run_notify INPUT_SUITE=API INPUT_ALLURE_SUMMARY="$TMP/allure/good.json" INPUT_STATUS=warning
check "explicit status wins: colour" warning "$(attachment .color)"
contains "explicit status wins: warning is not a pass" ":x:" "$TITLE"
run_notify INPUT_SUITE=API INPUT_ALLURE_SUMMARY="$TMP/allure/good.json" INPUT_SUMMARY="from the string input"
contains "the Allure summary wins over the string" "58 passed" "$(attachment .text)"
run_notify INPUT_SUITE=API INPUT_ALLURE_SUMMARY="$TMP/allure/missing.json" INPUT_SUMMARY="from the string input" INPUT_STATUS=good
check "missing file falls back to the string" "from the string input" "$(attachment .text)"
contains "missing file warns" "::warning" "$OUT"
run_notify INPUT_SUITE=API INPUT_ALLURE_SUMMARY="$TMP/allure/bad.json"
check "unparsable file: no results" "No test results" "$(attachment .text)"
check "unparsable file: danger" danger "$(attachment .color)"

echo "== nothing to report, bad status"
run_notify INPUT_ENVIRONMENT=vault-main INPUT_SUITE=API
check "no counts: text" "Environment: vault-main — No test results" "$(attachment .text)"
check "no counts: danger" danger "$(attachment .color)"
run_notify INPUT_SUITE=API INPUT_STATUS=blue
check "unknown status: danger" danger "$(attachment .color)"
contains "unknown status: warns" "::warning" "$OUT"

echo "== report field"
run_notify INPUT_SUITE=API INPUT_STATUS=good
check "no report url: fields" "Workflow,Trigger" "$(attachment '[.fields[].title] | join(",")')"
run_notify INPUT_SUITE=API INPUT_STATUS=good INPUT_REPORT_URL=https://allure.example/r/2
check "report label defaults to the url" "<https://allure.example/r/2 | https://allure.example/r/2>" "$(field 'Allure Report')"

echo "== hostile input stays inert"
EVIL="A\"B \`touch $TMP/pwned\` \$(touch $TMP/pwned2) \\ end"
run_notify INPUT_SUITE="$EVIL" INPUT_QUALIFIER="$EVIL" INPUT_STATUS=good
check "payload is valid JSON" 0 "$(printf '%s' "$PAYLOAD" | jq -e . >/dev/null 2>&1; echo $?)"
contains "metacharacters are rendered literally" "$EVIL Test Results" "$(attachment .title)"
pwned=no
for marker in "$TMP/pwned" "$TMP/pwned2"; do
  if [ -e "$marker" ]; then pwned=yes; fi
done
check "nothing was executed" "no" "$pwned"
run_notify INPUT_SUITE=$'two\nlines' INPUT_STATUS=good
check "newlines are flattened" "[legacy] :vault: two lines Test Results :green-check:" "$TITLE"

echo "== errors"
run_notify INPUT_ENVIRONMENT=vault-main
check "missing suite fails" 1 "$RC"
contains "missing suite is reported" "::error" "$OUT"
run_notify INPUT_SUITE=API INPUT_DRY_RUN=false INPUT_WEBHOOK=
check "empty webhook fails" 1 "$RC"
contains "empty webhook is reported" "::error" "$OUT"

echo "== delivery against a local mock Slack endpoint"
if command -v python3 >/dev/null 2>&1; then
  python3 "$HERE/mock_slack.py" "$TMP/port" "$TMP/received" &
  SERVER_PID=$!
  for _ in $(seq 1 50); do [ -s "$TMP/port" ] && break; sleep 0.1; done
  PORT="$(cat "$TMP/port" 2>/dev/null || true)"
  if [ -n "$PORT" ]; then
    : > "$TMP/received"
    run_notify INPUT_ENVIRONMENT=vault-next INPUT_SUITE=API INPUT_STATUS=good INPUT_SUMMARY="$COUNTS" \
      INPUT_DRY_RUN=false INPUT_WEBHOOK="http://127.0.0.1:$PORT/ok"
    check "200: exit code" 0 "$RC"
    lacks "200: no warning" "::warning" "$OUT"
    check "200: the body that arrived is the payload" "$PAYLOAD" "$(jq -c . "$TMP/received")"
    run_notify INPUT_SUITE=API INPUT_STATUS=good INPUT_DRY_RUN=false INPUT_WEBHOOK="http://127.0.0.1:$PORT/fail"
    check "HTTP 500: exit code stays 0" 0 "$RC"
    contains "HTTP 500: warns" "HTTP 500" "$OUT"
    run_notify INPUT_SUITE=API INPUT_STATUS=good INPUT_DRY_RUN=false INPUT_WEBHOOK="http://127.0.0.1:9/unreachable"
    check "unreachable: exit code stays 0" 0 "$RC"
    contains "unreachable: warns" "HTTP 000" "$OUT"
  else
    echo "SKIP delivery tests: the mock endpoint did not start"
  fi
else
  echo "SKIP delivery tests: python3 is not available"
fi

echo
echo "$((total - fails)) of $total checks passed"
[ "$fails" -eq 0 ]
