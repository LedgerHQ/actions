#!/usr/bin/env bash
# Build and post a standard Vault test-run notification to a Slack incoming webhook.
#
# Every input arrives through an INPUT_* environment variable set by action.yml and
# is passed to jq with --arg, so quotes or shell metacharacters in a title, a
# qualifier or a summary can neither break the JSON nor run as commands.
set -euo pipefail

ICON="https://emojis.slackmojis.com/emojis/images/1587484871/8712/github.png"

warn() { echo "::warning title=vault-test-notify::$*"; }
fail() { echo "::error title=vault-test-notify::$*"; exit 1; }
oneline() { printf '%s' "${1//$'\n'/ }"; }

server_url="${GITHUB_SERVER_URL:-https://github.com}"
repository="${GITHUB_REPOSITORY:-}"

environment="$(oneline "${INPUT_ENVIRONMENT:-}")"
detail="$(oneline "${INPUT_ENVIRONMENT_DETAIL:-}")"
suite="$(oneline "${INPUT_SUITE:-}")"
emoji="$(oneline "${INPUT_EMOJI-:vault:}")"
qualifier="$(oneline "${INPUT_QUALIFIER:-}")"
ref="$(oneline "${INPUT_REF:-}")"
report_url="$(oneline "${INPUT_REPORT_URL:-}")"
report_label="$(oneline "${INPUT_REPORT_PATH:-}")"

[ -n "$suite" ] || fail "the 'suite' input is required"

# --- environment: emoji + [tag] ---------------------------------------------
case "$environment" in
  vault-main) env_tag=":large_blue_circle: [main]" ;;
  vault-next) env_tag=":large_purple_circle: [next]" ;;
  minivault)  env_tag=":large_orange_circle: [minivault]" ;;
  vault-ppr)  env_tag=":black_circle: [ppr]" ;;
  prd)        env_tag=":white_circle: [prd]" ;;
  vault-qa)   env_tag=":argocd: [qa]" ;;
  argocd)     env_tag=":argocd: [argocd]" ;;
  "")         env_tag="" ;;
  *)          env_tag="[$environment]"
              warn "unknown environment '$environment': rendering a bare [tag]" ;;
esac

# --- stack: [legacy] | [revault], derived from the repository by default ------
stack="$(oneline "${INPUT_STACK:-}")"
if [ -z "$stack" ]; then
  if [ "$repository" = "LedgerHQ/revault" ]; then stack="revault"; else stack="legacy"; fi
fi
case "$stack" in legacy|revault) ;; *) warn "unexpected stack '$stack' (expected legacy or revault)" ;; esac

# --- counts and status ---------------------------------------------------------
# Path mode: read an Allure widgets/summary.json. String mode: use the summary input.
summary_text=""
allure_status=""
if [ -n "${INPUT_ALLURE_SUMMARY:-}" ]; then
  if [ -r "$INPUT_ALLURE_SUMMARY" ] && summary_text="$(jq -er '
      .statistic | select(type == "object")
      | "\(.passed // 0) passed, \(.failed // 0) failed, \(.broken // 0) broken, \(.skipped // 0) skipped, \(.total // 0) total"
    ' "$INPUT_ALLURE_SUMMARY" 2>/dev/null)"; then
    # Green only when something ran and nothing failed or is broken.
    if jq -e '.statistic | (.total // 0) > 0 and (.failed // 0) == 0 and (.broken // 0) == 0' "$INPUT_ALLURE_SUMMARY" >/dev/null 2>&1; then
      allure_status="good"
    else
      allure_status="danger"
    fi
  else
    summary_text=""
    warn "cannot read the Allure summary '$INPUT_ALLURE_SUMMARY'"
  fi
fi
summary_text="${summary_text:-$(oneline "${INPUT_SUMMARY:-}")}"
summary_text="${summary_text:-No test results}"

# An explicit status always wins over the Allure-derived one.
status="${INPUT_STATUS:-}"
case "$status" in
  good|danger|warning) ;;
  "") status="${allure_status:-danger}" ;;
  *)  warn "unknown status '$status' (expected good, danger or warning): using danger"; status="danger" ;;
esac
if [ "$status" = "good" ]; then status_emoji=":green-check:"; else status_emoji=":x:"; fi

# --- title ----------------------------------------------------------------------
title="${env_tag}[$stack] ${emoji:+$emoji }$suite Test Results"
[ -z "$qualifier" ] || title="$title ($qualifier)"
[ -z "$ref" ] || title="$title · $ref"
title="$title $status_emoji"

# --- body text ------------------------------------------------------------------
text="$summary_text"
if [ -n "$environment" ]; then
  env_line="Environment: $environment"
  [ -z "$detail" ] || env_line="$env_line / $detail"
  text="$env_line — $summary_text"
fi

# --- fields and footer: derived from the GitHub context -------------------------
workflow="$(oneline "${GITHUB_WORKFLOW:-}")"
run_id="${GITHUB_RUN_ID:-}"
if [ -n "$repository" ] && [ -n "$run_id" ]; then
  workflow_link="<$server_url/$repository/actions/runs/$run_id | ${workflow:-workflow run}>"
else
  workflow_link="${workflow:-workflow run}"
fi

event="${GITHUB_EVENT_NAME:-}"
actor="${GITHUB_ACTOR:-}"
if [ -n "$actor" ]; then actor_link="<$server_url/$actor | $actor>"; else actor_link=""; fi
case "$event" in
  schedule)          trigger="schedule" ;;
  workflow_dispatch) trigger="manual${actor_link:+ · $actor_link}" ;;
  "")                trigger="" ;;
  *)                 trigger="$event${actor_link:+ · $actor_link}" ;;
esac

if [ -n "$repository" ]; then footer="<$server_url/$repository | $repository>"; else footer=""; fi

fields="$(jq -n \
  --arg report_url "$report_url" \
  --arg report_label "${report_label:-$report_url}" \
  --arg workflow_link "$workflow_link" \
  --arg trigger "$trigger" \
  '[
    (if $report_url != "" then {title: "Allure Report", value: ("<" + $report_url + " | " + $report_label + ">"), short: true} else empty end),
    {title: "Workflow", value: $workflow_link, short: true},
    (if $trigger != "" then {title: "Trigger", value: $trigger, short: false} else empty end)
  ]')"

payload="$(jq -n -c \
  --arg color "$status" \
  --arg title "$title" \
  --arg text "$text" \
  --argjson fields "$fields" \
  --arg footer "$footer" \
  --arg icon "$ICON" \
  '{attachments: [{mrkdwn_in: ["mrkdwn"], color: $color, title: $title, text: $text, fields: $fields, footer: $footer, footer_icon: $icon}]}')"

if [ -n "${GITHUB_OUTPUT:-}" ]; then
  { echo "title=$title"; echo "payload=$payload"; } >> "$GITHUB_OUTPUT"
fi

# --- delivery -------------------------------------------------------------------
if [ "${INPUT_DRY_RUN:-false}" = "true" ]; then
  echo "dry-run: the payload below was not posted"
  echo "$payload" | jq .
  exit 0
fi

webhook="${INPUT_WEBHOOK:-}"
# An empty webhook is a configuration error (it is how a missing secret hid a whole
# channel's notifications): make it loud. Call sites set continue-on-error so a
# notification problem never turns a test run red.
[ -n "$webhook" ] || fail "the Slack webhook is empty (is the secret defined in this repository?): nothing was sent"
echo "::add-mask::$webhook"

body_file="$(mktemp "${RUNNER_TEMP:-${TMPDIR:-/tmp}}/vault-test-notify.XXXXXX")"
trap 'rm -f "$body_file"' EXIT
printf '%s' "$payload" > "$body_file"
code="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 20 \
  -X POST -H 'Content-Type: application/json' --data-binary @"$body_file" "$webhook")" || code="000"
if [ "$code" != "200" ]; then
  warn "Slack answered HTTP $code: the notification may not have been delivered"
fi
