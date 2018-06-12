
```r

var_integer_example <- c(1L, 2L, 3L)
class(var_integer_example)

var_class_example <- c(1,2,3)
class(var_class_example)
# defaults to numeric without integer


var_factor <- factor( c('male', 'female', 'male', 'male')   )
var_factor

class(var_factor)

# interested in
# factor_scope <- factor.scope(factor = var_factor, scope = )


```

| Dimension | Homogeneous | Heterogeneous |
| --- | --- | --- |
| one-dimension | Atomic vector | List |
| two-dimension | Matrix | Data frame |
| n-dimension | Array	– |  |
