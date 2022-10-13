let-env GITHUB_OUTPUT = ""
def-env "nugha push-output" [variables: table] {
    let exported_vars = ($variables | transpose | each {|var|
            echo $"($var.column0)=($var.column1)"
        } | str collect "\n"
    )
    let-env GITHUB_OUTPUT = ($"($env.GITHUB_OUTPUT)\n($exported_vars)" | str trim)
}