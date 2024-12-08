package core

import (
	"fmt"
	"math"
	"slices"
	"strconv"
	"strings"

	"github.com/charmbracelet/log"
)

// SolveDay1 - Solve the first day of the Advent of Code 2024
//
// Computation time for this is O(n log n) + O(n), that can be simplified to O(n log n)
//
// See the problem: https://adventofcode.com/2024/day/1
func SolveDay1ProblemOne(rawInput string) (*string, error) {
	leftList, rightList, err := ParsingProblemOneInput(rawInput)
	if err != nil {
		return nil, err

	}

	// Sorting the list of values, to make the distance calculation easier
	// Cost of this operation is O(n log n)
	slices.Sort(leftList)
	slices.Sort(rightList)

	// Calculate the distance between the two vectors, that is just O(n)
	distance := CalculateVecDistance(leftList, rightList)
	result := fmt.Sprintf("%d", distance)
	return &result, nil
}

func ParsingProblemOneInput(rawInput string) ([]int, []int, error) {
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
				return nil, nil, err
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
	return leftList, rightList, nil
}

func CalculateVecDistance(left, right []int) int {
	distanceList := make([]int, len(left))
	for idx := range len(left) {
		distanceList[idx] = CalculateDistance(left[idx], right[idx])
	}
	return SumList(distanceList)
}

func CalculateDistance(left, right int) int {
	minDist := math.Min(float64(left), float64(right))
	maxDist := math.Max(float64(left), float64(right))
	return int(maxDist) - int(minDist)
}

func SumList(list []int) int {
	sum := 0
	for _, val := range list {
		sum += val
	}
	return sum
}

// You'll need to figure out exactly how often each number from the left list
// appears in the right list. Calculate a total similarity score by adding up
// each number in the left list after multiplying it by the number of times that
// number appears in the right list.
//
// See https://adventofcode.com/2024/day/1#part2
func SolveDay1ProblemTwo(rawInput string) (*string, error) {
	leftList, rightList, err := ParsingProblemOneInput(rawInput)
	if err != nil {
		return nil, err
	}
	slices.Sort(leftList)
	slices.Sort(rightList)

	similarityList := make([]int, len(leftList))
	for idx, val := range leftList {
		similarityList[idx] = val * CountElement(rightList, val)
	}

	val := SumList(similarityList)
	result := fmt.Sprintf("%d", val)
	return &result, nil
}

func CountElement(list []int, element int) int {
	count := 0
	for _, val := range list {
		if val == element {
			count++
		}
	}
	return count
}
