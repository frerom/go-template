package main

import (
	"fmt"
	"log"

	"gopkg.in/yaml.v2"
)

var data = `
what: world!
`

func what() string {
	m := make(map[string]interface{})

	err := yaml.Unmarshal([]byte(data), &m)
	if err != nil {
		log.Fatalf("error: %v", err)
	}

	return fmt.Sprintf("%v", m["what"])
}

func Hello() string {
	return "Hello, " + what()
}

func main() {
	fmt.Println(Hello())
}
