package cmd

import "github.com/alecthomas/kong"

// CLI - The command line structure where the information are stored
var CLI struct {
	Verbose bool   `help:"Enable verbose mode."`
	Output  string `help:"Output file." type:"path" default:"./output"`
	Input   string `help:"Input file." type:"path" default:"./input"`
	Example bool   `help:"Load the example input file."`
	Run     struct {
		Day int `arg:"" help:"Day of the Advent of Code."`
	} `cmd:"" help:"Run a solution."`
}

func Parse() *kong.Context {
	return kong.Parse(&CLI)
}
