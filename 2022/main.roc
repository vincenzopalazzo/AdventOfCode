app "adventOfCode2022"
    packages {
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.1.1/zAoiC9xtQPHywYk350_b7ust04BmWLW00sjb9ZPtSQk.tar.br"
    }
    imports [
        pf.Stdout,
        pf.Task.{ Task },
        pf.Arg,
        Cli.{ parse }
    ]
    provides [main] to pf

main : Task {} []
main =
    args = parse Arg.list
    Stdout.line args