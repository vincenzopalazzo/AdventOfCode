module dayone

import utils
import strconv

/// This is the solution of the part one for the day 1
pub fn sonar_sweep(input_url string) int {
	inputs := prepare_input(input_url)
	mut counter := 0
	mut prev := inputs[0]
	for index in 1 .. inputs.len {
		elem := inputs[index]
		if elem > prev {
			counter++
		}
		prev = elem
	}
	return counter
}

pub fn sonar_sweep_sliding_windows(input_url string) int {
	input := prepare_input(input_url)
	mut counter := 0
	// We assume that all the value are positive or 0, so this is a invalid sum
	mut prev := -1
	mut start_window := 0
	mut end_window := start_window + 3

	for end_window <= input.len {
		mut sum := 0
		for index in start_window .. end_window {
			elem := input[index]
			sum += elem
		}
		if sum > prev {
			if prev != -1 {
				counter++
			}
		}
		prev = sum
		start_window++
		end_window++
	}

	return counter
}

// A utils function to load the input of the day one from a file.
fn prepare_input(url string) []int {
	raw_token := utils.get_input_from_file(url)

	mut inputs := []int{}
	for token in raw_token {
		inputs << strconv.atoi(token) or {
			println('$token is not a int value')
			exit(1)
		}
	}
	return inputs
}
