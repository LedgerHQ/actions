def-env "nugha push-output" [variables: table] {
    let exported_vars = ($variables | transpose | each {|var|
            echo $"($var.column0)=($var.column1)"
        } | str collect "\n"
    )
    $exported_vars | str trim | save $env.GITHUB_OUTPUT --append
}