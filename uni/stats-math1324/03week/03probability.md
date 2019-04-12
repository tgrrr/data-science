# Probability
- stats week3

tl;dr

Permutations:

n
k

### Permutations
P    n!
  ______
  (n-k)!
big P
little n
little k

### combinations = permutations x k!

C     n!
    ______
    (n-k)!k!

- Intersections
- Unions

## Goals:
List the basic principles of probability.
Express uncertainty using probability.
Define common probability terms.
Solve basic probability problems.
Solve problems involving permutations and combinations.

## Modules Questions

in R doc

Solutions and Answers

> tally(~SmartPhone + usr, data=Mobilephone, margins = TRUE)
                        usr
SmartPhone               Rural Suburban Urban <NA> Total
  Cell, smartphone         111      484   274   35   904
  Cell, not a smartphone   205      509   283   53  1050
  No cell                   73      147    80    0   300
  Total                    389     1140   637   88  2254

Pr(Rural) = 389/2254 = 0.17
Pr(NA) = 88/2254 = 0.04
Pr(Smartphone ∩ Urban) = 274/2254 = 0.12
Pr(Smartphone ∪ Cell) = (904 + 1050)/2254 = 0.87
Pr(Smartphone | Rural) = 111/389 = 0.29
Pr(Smartphone | Suburban) = 484/1140 = 0.42
Responses will vary, but you should be comparing the conditional probability of smartphone ownership between different residential areas. You should be able to conclude that the conditional probability of smartphone ownership is the highest for urban areas, and followed very closely by suburban areas. The conditional probability of smartphone ownership is substantially lower for rural areas.



## Dataset:
mobile phones
