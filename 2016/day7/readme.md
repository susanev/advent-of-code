# Advent of Code
## Day 7

### Part 1
An IP supports TLS if it has an Autonomous Bridge Bypass Annotation, or ABBA. An ABBA is any four-character sequence which consists of a pair of two different characters followed by the reverse of that pair, such as xyyx or abba. However, the IP also must not have an ABBA within any hypernet sequences, which are contained by square brackets.

For example:
* `abba[mnop]qrst` supports TLS (abba outside square brackets)
* `abcd[bddb]xyyx` does __not__ support TLS (bddb is within square brackets, even though xyyx is outside square brackets)
* `aaaa[qwer]tyui` does __not__ support TLS (aaaa is invalid; the interior characters must be different)
* `ioxxoj[asdfgh]zxcvbn` supports TLS (oxxo is outside square brackets, even though it's within a larger string)

How many IPs in your puzzle input support TLS?

[Part 1 Solution](part1.rb)

### Part 2
An IP supports SSL if it has an Area-Broadcast Accessor, or ABA, anywhere in the supernet sequences (outside any square bracketed sections), and a corresponding Byte Allocation Block, or BAB, anywhere in the hypernet sequences. An ABA is any three-character sequence which consists of the same character twice with a different character between them, such as xyx or aba. A corresponding BAB is the same characters but in reversed positions: yxy and bab, respectively.

For example:
* aba[bab]xyz supports SSL (aba outside square brackets with corresponding bab within square brackets)
* xyx[xyx]xyx does not support SSL (xyx, but no corresponding yxy)
* aaa[kek]eke supports SSL (eke in supernet with corresponding kek in hypernet; the aaa sequence is not related, because the interior character must be different)
* zazbz[bzb]cdb supports SSL (zaz has no corresponding aza, but zbz has a corresponding bzb, even though zaz and zbz overlap)

How many IPs in your puzzle input support SSL?

[Part 2 Solution](part2.rb)
