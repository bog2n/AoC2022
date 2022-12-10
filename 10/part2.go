package main

import (
	"bufio"
	"os"
	"fmt"
	"strings"
	"strconv"
)

var clock, x int = 0,1
var err error
var line string

func noop() {
	clock += 1
	clockpos := clock % 40
	if clockpos == 0 { clockpos = 40 }

	if clockpos == 1 { fmt.Printf("#") } // Dirty bug mitigation

	if clockpos == x || clockpos == x-1 || clockpos == x+1 {
		fmt.Printf("#")
	} else {
		fmt.Printf(" ")
	}
	if clockpos == 40 {
		fmt.Printf("\n")
	}
}

func addx(s string) {
	v, err := strconv.Atoi(s)
	if err != nil { panic(err) }

	noop()
	x += v
	noop()
}

func main() {
	stdin := bufio.NewReader(os.Stdin)

	for {
		line, err = stdin.ReadString(0x0a)
		if err != nil { break }
		line = strings.Trim(line, "\n")
		instruction := strings.Split(line, " ")

		switch instruction[0] {
		case "noop":
			noop()
		case "addx":
			addx(instruction[1])
		}
	}
}
