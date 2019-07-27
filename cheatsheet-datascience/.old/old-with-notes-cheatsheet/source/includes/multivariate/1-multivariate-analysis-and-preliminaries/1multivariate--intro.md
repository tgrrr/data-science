# Multivariate Analysis

<p>
$$
\begin{array}{cc}
{ e }_{ i }^{ T }{ e }_{ i }
\end{array}
$$ 
</p>

```tex
{ e }_{ i }^{ T }\quad { e }_{ i }
```

#### Notes before exams

Length of vector:
L<sub>x</sub> is |x| = sqrt(x1^2 + x2^2 ... + x(n)^2)

------------------------------------------------------

#### Goals
- Perform exploratory analysis of multivariate data collected within your field of - specialisation;
- Test for **multivariate normality** of the data;
- Apply **multivariate statistical methods** via:
  - hypothesis testing,
  - point estimation and
  - confidence interval estimation;
- Perform data reduction using principal component analysis;
- Apply multivariate techniques such as **factor analysis** and **cluster analysis** to study the - population structure;
- **SAS** Use SAS, statistical software packages to analyse multivariate data.

# 1. Multivariate Analysis and Preliminaries

## TODOLATER:

- Click the link to go to the MATH2142 Part A & B Links to an external site. Course guide.
- Click the link to go to the MATH1309 Part A & B Links to an external site. Course guide.

#### Sources:

- https://gosoapbox.rmit.edu.au/event/587975732/#!/dashboard
- http://tiny.cc/MATH1309
- https://onedrive.live.com/view.aspx?resid=870A15F5B3481AC0!1225&app=OneNote&authkey=!AAQWedHobp9zKZQ
- alice.johnstone@rmit.edu.au
- https://www.gapminder.org/tools/#$chart-type=bubbles cool chart

## Vectors and Maths


L <sub>x</sub>
is length of Vectors

Multiplication of

If we have col multiplied by row,
we end up with a matrix

## Matrices

Rectangular array of real numbers
Different subscripts


A = A<sub>m x n</sub>

m x n is size of matrix
i and j is position in matrix


## Transpose of matrix
is flipping it over: 1st col becomes first row, and vice versa

shorthand is A'

A<sup>T</sup><sub>3x2</sub> => A<sup>I</sup><sub>2x3</sub>


### Maths on Matrices

If we multiply by constant => multiply everything in matrix by the constant
- has same size

### Adding Matrices
- We do maths on elements in similar positions

### Multiply Matrices

- AB<sub>(2x3) (3x1)</sub> (the second and )
- Take each element in A

[ 3, -1, 2 ]        [-2]        [3x-2 + -1*7 + 2*9]
[ 1, 5, 4  ]     x  [7]    =  
                    [9]
                    
- Multiply first row left by first column right
- Multiply first row left by second col right
- Third row left by third col right

### Square matrix

### Symetrical matrix

### Identity of matrix

### Inverse of Matrix

If Matrix B

### TODOLATER: Orthoginal

QT Q = QQT = I.

### Quadratic form

TODOLATER:
x<sup>T</sup>Ax = tr(x<sup>T</sup>Ax) = tr(Axx<sup>T</sup>)

### TODOLATER: Trace of matrix

`tr(BC) = tr(CB)`

### TODOLATER: Determinant

= Way to summarise entire matrix with a single number

TODOLATER: formula

#### for 2x2
if A<sub>2x2</sub> |A| =  | a b |
                          | c d |

=> ad - bc

#### For A 3x3

TODOLATER: this is the same as the way I do sudoku.
  Cross out patterns

|  |
| --- |
| a b c |
| d e f |
| g h i |


= a(ei - fh)
  b(di - fg)
  c(dh - eg)
  
### Eigenvalues and Eigenvectors

TODOLATER: plenty of stuff on one-note.
  Move to here

`Ae = λe`

`Ae = lambda.e`

TODOLATER: lambda is characteristic root

- Eigenvalue of A: |A=lambdaI| = 0
- there are n eigenvalues for a matrix of order n

lambda is not necessarily unique

### Spectral Decomposition

### Positive definition Matrix




## Random Vectors

3.1 Moments of random vectors (And potentially random variables)
If

### Population mean vector (u in bold)
- Look for bold type

### Population covariance matrix

How do the variables vary together


TODOLATER: formula

TODOLATER: This gives:

Observation and how different it is from it's mean