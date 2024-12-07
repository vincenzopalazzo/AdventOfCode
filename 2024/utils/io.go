package utils

import (
	"fmt"
	"os"
)

// ReadFile - Read a file from a path and return the content as a string
func ReadFile(path string, fileName string) (*string, error) {
	filePath := fmt.Sprintf("%s/%s", path, fileName)
	if file, err := os.Open(filePath); err != nil {
		return nil, err
	} else {
		defer file.Close()
		if content, err := os.ReadFile(filePath); err != nil {
			return nil, err
		} else {
			contentString := string(content)
			return &contentString, nil
		}
	}
}

// WriteFile - Write a file in a path with a specific content
func WriteFile(path string, fileName string, content *string) error {
	filePath := fmt.Sprintf("%s/%s", path, fileName)
	if file, err := os.Create(filePath); err != nil {
		return err
	} else {
		defer file.Close()
		if _, err := file.WriteString(*content); err != nil {
			return err
		}
	}
	return nil
}
