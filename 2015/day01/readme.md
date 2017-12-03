# Advent of Code
## Day 1

### Part 1
He starts on the ground floor (floor 0) and then follows the instructions one character at a time.

An opening parenthesis, (, means he should go up one floor, and a closing parenthesis, ), means he should go down one floor.

For example:
(()) and ()() both result in floor 0.
((( and (()(()( both result in floor 3.
))((((( also results in floor 3.
()) and ))( both result in floor -1 (the first basement level).
))) and )())()) both result in floor -3.

To what floor do the instructions take Santa?

[Part 1 Solution](part1.rb)

### Part 2
Now, given the same instructions, find the position of the first character that causes him to enter the basement (floor -1). The first character in the instructions has position 1, the second character has position 2, and so on.

For example:
) causes him to enter the basement at character position 1.
()()) causes him to enter the basement at character position 5.

What is the position of the character that causes Santa to first enter the basement?

[Part 2 Solution](part2.rb)