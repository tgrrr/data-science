

Tut w7

          
|        | Target -> | 1   | 2   | 3   | 4   | 5   |     |
| ------ | --------- | --- | --- | --- | --- | --- | --- |
| origin | 1         |     | 1   | 1   |     |     |     |
|        | 2         |     |     | 1   |     |     |     |
|        | 3         |     |     |     |     | 1   |     |
|        | 4         | 1   |     | 1   |     |     |     |
|        | 5         |     |     |     |     |     |     |
|        |           |     |     |     |     |     |     |


3. Draw a `path` and a `non-path walk` for the following graph.

`path` = A walk where nodes and edges are distinct is
called a path
answer: 1 3 2 8 9

`non-path walk`
9 8 2 3 7 8


> Closed walk: A walk returns to where it starts

3 2 8 7 3

> Open walk: A walk does not end where it starts

1 3 2 8 9

Diameter:

```math
\text {diameter}_{G}=\max _{\left(v_{i}, v_{j}\right) \in V \times V} l_{i, j}
```

Compute the diameter:
> The diameter of a graph is the length of the
==longest shortest path== between any pair of nodes
between any pairs of nodes in the graph
