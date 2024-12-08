package core

import (
	"fmt"
	"slices"
	"strconv"
	"strings"

	"github.com/charmbracelet/log"
)

// SolveDay2 - Solve the second day of the Advent of Code 2024
//
// See the problem: https://adventofcode.com/2024/day/2
func SolveDay2ProblemOne(rawInput string) (*string, error) {
	report, err := ParsingProblemTwoInput(rawInput)
	if err != nil {
		return nil, err
	}

	safe := CountReportSafe(report, false)

	result := fmt.Sprintf("%d", safe)
	return &result, nil
}

// This example data contains six reports each containing five levels.
func ParsingProblemTwoInput(rawInput string) ([][]int, error) {
	rawInputLines := strings.Split(rawInput, "\n")

	matrix := make([][]int, len(rawInputLines))
	for idx, line := range rawInputLines {
		lineCols := strings.Split(line, " ")

		matrixRow := make([]int, len(lineCols))
		for idx, col := range lineCols {
			log.Infof("Col: %s at idx `%d`", col, idx)
			value, err := strconv.Atoi(col)
			if err != nil {
				return nil, err
			}
			matrixRow[idx] = value
		}
		matrix[idx] = matrixRow
	}
	return matrix, nil
}

// IsReportSafe - Check if the report is safe
//
// The engineers are trying to figure out which reports are safe. The
// Red-Nosed reactor safety systems can only tolerate levels that are
// either gradually increasing or gradually decreasing.
//
// So, a report only counts as safe if both of the following are true:
//
// - The levels are either all increasing or all decreasing.
// - Any two adjacent levels differ by at least one and at most three.
func CountReportSafe(report [][]int, tolerate bool) int {
	safeReports := 0
	for reportIdx, level := range report {
		log.Debugf("Level: %v at idx `%d`", level, reportIdx)

		currentLevel := level
		reverseLevel := make([]int, len(level))
		copy(reverseLevel, level)

		// FIXME: we should run an error correction algorithm to fix the level
		slices.Reverse(reverseLevel)
		if !slices.IsSorted(level) && !slices.IsSorted(reverseLevel) {
			log.Warnf("The level %v or the reverse %v is not sorted", level, reverseLevel)
			continue
		}

		if slices.IsSorted(reverseLevel) {
			currentLevel = reverseLevel
		}

		isSafe := true
		weTolerate := !tolerate
		// Check if the difference between the levels is between 1 and 3
		for idx := range len(level) {
			if idx == 0 {
				continue
			}

			log.Infof("Check the difference between the levels %d and %d", currentLevel[idx], currentLevel[idx-1])
			diff := currentLevel[idx] - currentLevel[idx-1]
			log.Infof("The difference is %d", diff)
			if diff < 1 || diff > 3 {
				if weTolerate {
					isSafe = false
					log.Warnf("The difference between the levels %d and %d is not between 1 and 3", currentLevel[idx], currentLevel[idx-1])
					break
				}
				log.Warnf("Removing level %d from %d", currentLevel[idx], reportIdx)
				weTolerate = true
			}
		}

		if isSafe {
			safeReports++
		}
	}

	return safeReports
}

// SolveDay2 - Solve the second day of the Advent of Code 2024
//
// See the problem: https://adventofcode.com/2024/day/2
func SolveDay2ProblemTwo(rawInput string) (*string, error) {
	report, err := ParsingProblemTwoInput(rawInput)
	if err != nil {
		return nil, err
	}

	safe := CountReportSafe(report, true)

	result := fmt.Sprintf("%d", safe)
	return &result, nil
}
