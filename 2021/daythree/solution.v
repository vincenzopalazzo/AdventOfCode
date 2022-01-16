module daythree

import utils
import math

struct Diagnostic {
mut:
	gamma_rate  string
	epslon_rate string
}

pub fn find_diagnostic_report(input_url &string) int {
	status := prepare_input(input_url)

	if status.len == 0 {
		println('inputs empity')
		exit(1)
	}

	mut diagnostic := Diagnostic{
		gamma_rate: ''
		epslon_rate: ''
	}
	// calculate the common bits
	size := status[0].len

	for pos in 0 .. size {
		diagnostic.gamma_rate += most_common_bit(status, pos)
	}

	for bit in diagnostic.gamma_rate {
		match bit {
			*c'1' {
				diagnostic.epslon_rate += '0'
			}
			*c'0' {
				diagnostic.epslon_rate += '1'
			}
			else {
				println('bit unrecognize')
				exit(1)
			}
		}
	}
	return to_decimal(diagnostic.gamma_rate) * to_decimal(diagnostic.epslon_rate)
}

pub fn calculate_life_support(input_url &string) int {
	status := prepare_input(input_url)
	oxygen := oxygen_generator_rating(status, 0, 1)
	co2 := co2_scrubber_rating(status, 0, 0)
	println(oxygen)
	println(co2)
	return oxygen * co2
}

// Calculate the oxygen generator rating
//
// Procedure is:
// - build the most common bits table by index
// - use the most common map result as input of the next recursive call
// - is we have aquality in the most common bit at position index return the choice value
fn oxygen_generator_rating(bits_list []string, index int, choice int) int {
	cmp := fn (a int, b int) bool {
		return a > b
	}
	binary_number := life_support_helper(bits_list, index, choice, cmp)
	return to_decimal(binary_number[0])
}

// Calculate the co2 scribber rating
//
// Procedure s the same of oxygen_generator_rating
fn co2_scrubber_rating(bits_list []string, index int, choice int) int {
	cmp := fn (a int, b int) bool {
		return a < b
	}
	binary_number := life_support_helper(bits_list, index, choice, cmp)
	return to_decimal(binary_number[0])
}

// Function that contains the recursion common logic to solve the life support
// problem
fn life_support_helper(bits_list []string, at int, def_choice int, cmp fn (int, int) bool) []string {
	// TODO: build the most common bits map
	// select the biggest bits, and return the winner list
	// otherwise continue the recursion
	// Commons list map
	if bits_list.len == 1 {
		println(bits_list)
		return bits_list
	}
	mut commons_bits := map[string][]string{}
	for bits_item in bits_list {
		assert bits_item.len > at
		bit := bits_item[int(at)].ascii_str()
		if bit in commons_bits {
			mut value := commons_bits[bit]
			value << bits_item
			commons_bits[bit] = value
		} else {
			mut value := []string{}
			value << bits_item
			commons_bits[bit] = value
		}
	}
	ones := commons_bits['1']
	zeros := commons_bits['0']

	if cmp(ones.len, zeros.len) {
		return life_support_helper(ones, at + 1, def_choice, cmp)
	} else if cmp(ones.len, zeros.len) {
		return life_support_helper(zeros, at + 1, def_choice, cmp)
	} else {
		if def_choice == 1 {
			return life_support_helper(ones, at + 1, def_choice, cmp)
		} else {
			return life_support_helper(zeros, at + 1, def_choice, cmp)
		}
	}
}

fn to_decimal(binary_str string) int {
	mut value := 0
	for index in 0 .. binary_str.len {
		mut bit := 0
		exp := binary_str.len - index - 1
		val := binary_str[index]
		match val {
			49 {
				bit = 1
			}
			else {
				bit = 0
			}
		}
		value += bit * int(math.pow(2, exp))
		// println('from $val -> $bit * 2^$exp = $value')
	}
	return value
}

fn most_common_bit(inputs []string, pos int) string {
	mut count_zeros := 0
	mut count_ones := 0
	for input in inputs {
		if pos > input.len {
			println('Position value graiter that the input len')
			exit(1)
		}
		match input[pos] {
			*c'1' {
				count_ones++
			}
			*c'0' {
				count_zeros++
			}
			else {
				println('bit unrecognize')
				exit(1)
			}
		}
	}

	return if count_ones > count_zeros { '1' } else { '0' }
}

fn prepare_input(input_url &string) []string {
	inputs := utils.get_input_from_file(input_url)
	return inputs
}
