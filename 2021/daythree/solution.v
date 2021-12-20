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

pub fn oxygen_generator_rating(input_url &string) int {
	return 0
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
