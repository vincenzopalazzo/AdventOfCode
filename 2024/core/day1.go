package core

import (
	"fmt"
	"strconv"
	"strings"

	"github.com/charmbracelet/log"
)

// SolveDay1 - Solve the first day of the Advent of Code 2024
//
// See the problem: https://adventofcode.com/2024/day/1
func SolveDay1ProblemOne(rawInput string) (*string, error) {
	leftList, rightList := []int{}, []int{}

	rawInputLines := strings.Split(rawInput, "\n")
	for _, line := range rawInputLines {
		lineCols := strings.Split(line, " ")
		for idx, col := range lineCols {
			log.Infof("Col: %s at idx `%d`", col, idx)
			if col == "" {
				continue
			}

			colInt, err := strconv.Atoi(col)
			if err != nil {
				return nil, err
			}

			switch idx {
			case 0:
				leftList = append(leftList, colInt)
			case 3:
				rightList = append(rightList, colInt)
			default:
				log.Warnf("Column index not expected: %d %s", idx, col)
			}
		}
	}

	log.Infof("Left list: %v", leftList)
	log.Infof("Right list: %v", rightList)
	return nil, fmt.Errorf("Not implemented")
}
