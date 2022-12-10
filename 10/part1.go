package main

import (
	"bufio"
	"os"
	"fmt"
	"strings"
	"strconv"
)

var clock, x, sum int = 1,1,0
var err error
var line string

func calc() {
	sum += clock * x
}

func noop() {
	clock += 1
	if (clock + 20) % 40 == 0 {
		calc()
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
	fmt.Printf("%d\n", sum)
}
