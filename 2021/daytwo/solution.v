module daytwo

import utils
import strconv

struct Indication {
pub:
	operation string 
	value int 
}

struct Position {
	mut:
	deep int
	horizontal_pos int
}

pub fn calculate_final_deep(input_url string) int {
	indications := prepare_input(input_url)
	mut pos := Position{
		deep: 0,
		horizontal_pos: 0,
	}
	for indication in indications {
		match indication.operation {
			"forward" {
				pos.horizontal_pos += indication.value
			}
			"up" {
				pos.deep -= indication.value
			}
			"down" {
				pos.deep += indication.value
			}
			else {
				println("unsupported operation")
				exit(1)
			}
		}
	}
	return pos.deep * pos.horizontal_pos
}

// Position struct with the add requirements of the 
// part two of the day
struct PositionEvol {
	mut:
	deep int
	horizontal_pos int
	aims int
}

// Evolution function for the problem two of the day
pub fn calculate_final_deep_evol(input_url string) int {
	indications := prepare_input(input_url)
	mut pos := PositionEvol{
		deep: 0,
		horizontal_pos: 0,
		aims: 0,
	}
	for indication in indications {
		match indication.operation {
			"forward" {
				pos.horizontal_pos += indication.value
				pos.deep += pos.aims * indication.value
			}
			"up" {
				pos.aims -= indication.value
			}
			"down" {
				pos.aims += indication.value
			}
			else {
				println("unsupported operation")
				exit(1)
			}
		}
	}
	return pos.deep * pos.horizontal_pos
}


fn prepare_input(input_url string) []Indication {
	inputs := utils.get_input_from_file(input_url)
	
	mut indications := []Indication{}
	// Split indication
	for line in inputs {
		tokens := line.split(" ")
		indications << Indication{
			operation: tokens[0],
			value: strconv.atoi(tokens[1]) or {
				println("The value ${tokens[1]} is not a integer")
				exit(1)
			}
		}
	}
	return indications
}