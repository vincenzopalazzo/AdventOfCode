package main

import (
	"fmt"
	"os"

	"github.com/charmbracelet/log"

	"github.com/vincenzopalazzo/AdventOfCode/2024/cmd"
	"github.com/vincenzopalazzo/AdventOfCode/2024/core"
	"github.com/vincenzopalazzo/AdventOfCode/2024/utils"
)

var Solutions = map[int]func(string) (*string, error){
	1: core.SolveDay1,
}

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
		contentString := ""
		if content, err := utils.ReadFile(inputPath, inFileName); err != nil {
			log.Errorf("Error reading file %s", err)
			os.Exit(1)
		} else {
			contentString = *content
		}

		sol, ok := Solutions[day]
		if !ok {
			log.Errorf("Day %d not implemented", day)
			os.Exit(1)
		}
		output, err := sol(contentString)
		if err != nil {
			log.Errorf("Error solving day %d: %s", day, err)
			os.Exit(1)
		}

		outFileName := fmt.Sprintf("aoc2024_day%d.out", day)
		if err := utils.WriteFile(outputPath, outFileName, output); err != nil {
			log.Errorf("Error writing file %s", err)
			os.Exit(1)
		}
		log.Infof("File %s written", outFileName)
	default:
		log.Errorf("%s is not a valid command", args.Command())
	}
}
