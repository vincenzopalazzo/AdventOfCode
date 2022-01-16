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
	oxygen := oxygen_generator_rating(status)
	co2 := co2_scrubber_rating(status)
	println('oxygen $oxygen')
	println('co2 $co2')
	return oxygen * co2
}

// Calculate the oxygen generator rating
//
// Procedure is:
// - build the most common bits table by index
// - use the most common map result as input of the next recursive call
// - is we have aquality in the most common bit at position index return the choice value
fn oxygen_generator_rating(bits_list []string) int {
	cmp := fn (ones []string, zeros []string) []string {
		if ones.len > zeros.len {
			return ones
		} else if ones.len < zeros.len {
			return zeros
		}
		return ones
	}
	binary_number := life_support_helper(bits_list, 0, cmp)
	assert binary_number.len == 1
	return to_decimal(binary_number[0])
}

// Calculate the co2 scribber rating
//
// Procedure s the same of oxygen_generator_rating
fn co2_scrubber_rating(bits_list []string) int {
	cmp := fn (ones []string, zeros []string) []string {
		if ones.len > zeros.len {
			return zeros
		} else if ones.len < zeros.len {
			return ones
		}
		return zeros
	}
	binary_number := life_support_helper(bits_list, 0, cmp)
	assert binary_number.len == 1
	return to_decimal(binary_number[0])
}

// Function that contains the recursion common logic to solve the life support
// problem
fn life_support_helper(bits_list []string, at int, cmp fn ([]string, []string) []string) []string {
	// 1. build the most common bits map
	// 1.1 select the biggest bits, and return the winner list
	// 1.2 otherwise continue the recursion
	if bits_list.len == 1 {
		println(bits_list)
		return bits_list
	}
	mut commons_bits := map[string][]string{}
	for bits_item in bits_list {
		assert bits_item.len > at
		bit := bits_item[at].ascii_str()
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

	new_list := cmp(ones, zeros)
	return life_support_helper(new_list, at + 1, cmp)
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
