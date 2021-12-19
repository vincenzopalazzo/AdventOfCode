module main

import os
import flag
import dayone

struct AdventureOfCode {
mut:
	day     string
	problem string
	input   string
}

fn configure_cmd_args() AdventureOfCode {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('Adventure of code 2021')
	fp.version('v0.0.1')
	fp.description('Adventure of Code 2021 solution')

	day_str := fp.string('day', `d`, "1", "The day of the problem in the adventure code list")
	problem_str := fp.string('problem', `b`, '1', "The problem of the day")
	input_str := fp.string('input', `i`, '', 'The input for the problem')

	fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		exit(1)
	}

	return AdventureOfCode{
		day: day_str,
		problem: problem_str,
		input: input_str,
	}
}

fn main() {
	conf := configure_cmd_args()
	target := conf.day + '_' + conf.problem

	match target {
		'1_1' {
			println(dayone.sonar_sweep(conf.input))
		}
		else {
			println('Error, the day ${conf.day} and problem ${conf.problem} are not supported')
			exit(1)
		}
	}
}
