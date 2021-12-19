module dayone

import utils 
import strconv

pub fn sonar_sweep(input_url string) int {
	inputs := prepare_input(input_url)
	mut counter := 0 
	mut prev := inputs[0]
	for index in 1..inputs.len - 1 {
		elem := inputs[index]
		if elem > prev {
			counter++
		}
		prev = elem
	}
	return counter
}

fn prepare_input(url string) []int {
	raw_token := utils.get_input_from_file(url)

	mut inputs := []int{}
	for token in raw_token {
		inputs << strconv.atoi(token) or {
			println("$token is not a int value")
			exit(1)
		}
	}
	return inputs
}
