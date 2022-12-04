interface Cli
    exposes [
        parse
    ]
   imports [ pf.Stdout, pf.Task.{ Task } ]

# parse the command line arguments
parse : Task {} []
parse = \args -> Stdout.line args