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
	// Day 1 - Problem 1 = 2
	2: core.SolveDay1ProblemOne,
	// Day 1 - Problem 2 = 3
	3: core.SolveDay1ProblemTwo,
}

func main() {
	args := cmd.Parse()

	inputPath := cmd.CLI.Input
	outputPath := cmd.CLI.Output
	switch args.Command() {
	case "run <day> <problem>":
		day := cmd.CLI.Run.Day
		problem := cmd.CLI.Run.Problem
		log.Infof("Running day `%d` problem `%d`", day, problem)

		// FIXME: we should be able to load also the example input file, before running
		// the solution. This is not implemented yet.
		inFileName := fmt.Sprintf("aoc2024_day%d", day)
		if cmd.CLI.Example {
			inFileName += "eg"
		}
		inFileName += fmt.Sprintf("_es%d.in", problem)
		contentString := ""
		if content, err := utils.ReadFile(inputPath, inFileName); err != nil {
			log.Errorf("Error reading file %s", err)
			os.Exit(1)
		} else {
			contentString = *content
		}

		sol, ok := Solutions[day+problem]
		if !ok {
			log.Errorf("Day %d not implemented", day)
			os.Exit(1)
		}
		output, err := sol(contentString)
		if err != nil {
			log.Errorf("Error solving day %d: %s", day, err)
			os.Exit(1)
		}
		log.Infof("Solution: %s", *output)

		outFileName := fmt.Sprintf("aoc2024_day%d", day)
		if cmd.CLI.Example {
			outFileName += "eg"
		}
		outFileName += fmt.Sprintf("_es%d.in", problem)
		if err := utils.WriteFile(outputPath, outFileName, output); err != nil {
			log.Errorf("Error writing file %s", err)
			os.Exit(1)
		}
		log.Infof("File %s written", outFileName)
	default:
		log.Errorf("%s is not a valid command", args.Command())
	}
}
