def best(right, str, size, edges, loops)
  possible_nexts = edges[right].keys
  return [str + right, [size, str + right]] if possible_nexts.empty?

  possible_nexts.map { |next_right|
    decrement(edges, next_right, right)
    decrement(edges, right, next_right)
    # Right end is X, and we add [X, Y]
    # New right end is Y and we add X + X to our score.
    # If there are any [X, X] domino, we also add all of them as well.
    # That adds 2X * the number of [X, X] dominoes.
    added = loops[right] + 1
    loops[right] = 0
    best(next_right, str + right * 2 * added, size + added, edges, loops).tap {
      edges[next_right][right] += 1
      edges[right][next_right] += 1
      loops[right] = added - 1
    }
  }.transpose.map(&:max)
end

def decrement(edges, a, b)
  if edges[a][b] == 1
    edges[a].delete(b)
  else
    edges[a][b] -= 1
  end
end

edges = Hash.new { |h, k| h[k] = Hash.new(0) }
loops = Hash.new(0)

(ARGV.empty? ? DATA : ARGF).each_line { |l|
  a, b = l.split(?/).map(&:to_i)
  if a == b
    # Fewer recursive calls by treating all [X, X] dominoes specially.
    # Cuts runtime to about 1/7 of the original.
    loops[a] += 1
  else
    edges[a][b] += 1
    edges[b][a] += 1
  end
}

part1, (_, part2) = best(0, 0, 1, edges, loops)
puts part1
puts part2

__END__
42/37
28/28
29/25
45/8
35/23
49/20
44/4
15/33
14/19
31/44
39/14
25/17
34/34
38/42
8/42
15/28
0/7
49/12
18/36
45/45
28/7
30/43
23/41
0/35
18/9
3/31
20/31
10/40
0/22
1/23
20/47
38/36
15/8
34/32
30/30
30/44
19/28
46/15
34/50
40/20
27/39
3/14
43/45
50/42
1/33
6/39
46/44
22/35
15/20
43/31
23/23
19/27
47/15
43/43
25/36
26/38
1/10