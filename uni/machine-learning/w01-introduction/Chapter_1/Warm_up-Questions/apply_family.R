# Review of Apply Families ----
x <- rnorm(100, 0.1, 1)
y <- rnorm(100, 0, 1.5)

test <- cor.test(x, y)
test$p.value

# Review of && vs & and || vs |
(2:4 >= 2) | (2:4 <= 2)
(2:4 >= 2) || (2:4 <= 2)

(2:4 >= 2) & (2:4 <= 2)
(2:4 >= 2) && (2:4 <= 2)

TRUE || a
TRUE | a
