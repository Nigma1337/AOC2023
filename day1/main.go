package main

import (
	_ "embed"
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

//go:embed input.txt
var input string
var regex = regexp.MustCompile(`[^0-9/\n]+`)

func main() {
	input_pt1 := regex.ReplaceAllString(input, "")
	fmt.Println("Part 1:", fetchNums(input_pt1))
	nums := map[*regexp.Regexp]string{
		regexp.MustCompile("(o)(ne)"):   " 1 ",
		regexp.MustCompile("(t)(wo)"):   " 2 ",
		regexp.MustCompile("(thr)(ee)"): " 3 ",
		regexp.MustCompile("(fo)(ur)"):  " 4 ",
		regexp.MustCompile("(fi)(ve)"):  " 5 ",
		regexp.MustCompile("(s)(ix)"):   " 6 ",
		regexp.MustCompile("(sev)(en)"): " 7 ",
		regexp.MustCompile("(eig)(ht)"): " 8 ",
		regexp.MustCompile("(ni)(ne)"):  " 9 ",
	}
	for key, value := range nums {
		input = key.ReplaceAllString(input, "$1"+value+"$2")
	}
	input := regex.ReplaceAllString(input, "")
	fmt.Println("Part 2:", fetchNums(input))
}

func fetchNums(input string) int {
	var res int
	sp := strings.Split(input, "\n")
	for _, text := range sp {
		a := string(text[0]) + string(text[len(text)-1])
		b, _ := strconv.Atoi(a)
		res += b
	}
	return res
}
