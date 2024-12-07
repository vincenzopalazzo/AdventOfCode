package main

import (
	"fmt"
	"os"

	"github.com/charmbracelet/log"

	"github.com/vincenzopalazzo/AdventOfCode/2024/cmd"
	"github.com/vincenzopalazzo/AdventOfCode/2024/utils"
)

func main() {
	args := cmd.Parse()

	inputPath := cmd.CLI.Input
	outputPath := cmd.CLI.Output
	switch args.Command() {
	case "run <day>":
		day := cmd.CLI.Run.Day
		log.Infof("Running day `%d`", day)
		// FIXME: load the file from input, and the file template is aoc2024_1.in
		inFileName := fmt.Sprintf("aoc2024_day%d.in", day)
		if content, err := utils.ReadFile(inputPath, inFileName); err != nil {
			log.Errorf("Error reading file %s", err)
			os.Exit(1)
		} else {
			log.Infof("Content of file %s", *content)
		}

		outFileName := fmt.Sprintf("aoc2024_day%d.out", day)
		if err := utils.WriteFile(outputPath, outFileName, "Hello World"); err != nil {
			log.Errorf("Error writing file %s", err)
			os.Exit(1)
		}
		log.Infof("File %s written", outFileName)
	default:
		log.Errorf("%s is not a valid command", args.Command())
	}
}
