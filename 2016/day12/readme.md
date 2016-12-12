# Advent of Code
## Day 2

### Part 1
The assembunny code you've extracted operates on four registers (a, b, c, and d) that start at 0 and can hold any integer. However, it seems to make use of only a few instructions:
* `cpy x y` copies `x` (either an integer or the value of a register) into register `y`.
* `inc x` increases the value of register `x` by one.
* `dec x` decreases the value of register `x` by one.
* `jnz x y` jumps to an instruction `y` away (positive means forward; negative means backward), but only if `x` is not zero.

The `jnz` instruction moves relative to itself: an offset of -1 would continue at the previous instruction, while an offset of 2 would skip over the next instruction.

For example:

```
cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a
```

The above code would set register a to 41, increase its value by 2, decrease its value by 1, and then skip the last dec a (because a is not zero, so the jnz a 2 skips it), leaving register a at 42. When you move past the last instruction, the program halts.

After executing the assembunny code in your puzzle input, what value is left in register a?

[Part 1 Solution](part1.rb)

### Part 2
As you head down the fire escape to the monorail, you notice it didn't start; register c needs to be initialized to the position of the ignition key.

If you instead initialize register c to be 1, what value is now left in register a?

[Part 2 Solution](part2.rb)