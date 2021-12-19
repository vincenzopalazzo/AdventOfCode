module utils

import net.http
import os

pub fn get_input_from_http(url string) string {
	return http.get_text(url)
}

pub fn get_input_from_file(path string) []string {
	return os.read_lines(path) or {
		println("Error with the path $path")
		exit(1)
	}
}

pub fn parse_input_file(file_conten string) []string {
	return file_conten.split("\n") 
}