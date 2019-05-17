## Eigenvalues


`|A - λI| = 0`

Eigenvalues for A can be found by solving `|A - λI| = 0`

`Ae = λe`

<p>
$$
\begin{array}{cc}
{ e }_{ i }^{ T }{ e }_{ i }
\end{array}
$$ 
</p>


Howto:

A = {
  1 0,
  1 3
}

| A - λI | = 0 |
| --- | --- |


\left| \left[ \begin{matrix} 1 & 0 \\ 1 & 3 \end{matrix} \right] -\lambda \left[ \begin{matrix} 1 & 0 \\ 0 & 1 \end{matrix} \right]  \right| \quad =\quad 0\\ \left| \left[ \begin{matrix} 1-\lambda  & \quad 0 \\ 1 & 3-\lambda  \end{matrix} \right]  \right| \quad =\quad 0

___________________________________

<p>
$$
\begin{array}{cc}
\begin{eqnarray} 0 & = & |A-λI| \\ 0 & = & \left| \left[ \begin{matrix} 1 & 0 \\ 1 & 3 \end{matrix} \right] -\lambda \left[ \begin{matrix} 1 & 0 \\ 0 & 1 \end{matrix} \right]  \right|  \\ 0 & = & \left| \left[ \begin{matrix} 1-\lambda  & \quad 0 \\ 1 & 3-\lambda  \end{matrix} \right]  \right|  \\ \begin{vmatrix} a & b \\ c & d \end{vmatrix} & = & ad-bc \\ 0 & = & (1-\lambda )(3-\lambda )-0\times 1 \\ 0 & = & (1-\lambda )(3-\lambda ) \\ { \lambda  }_{ 1 } & = & 1 \\ { \lambda  }_{ 2 } & = & 3 \end{eqnarray}
\end{array}
$$ 
</p>


___________________________________

TODOLATER: plenty of stuff on one-note.
  Move to here

e<sub>i</sub><sup>T</sup> e<sub>i</sub> = 1

`Ae = lambda.e`

TODOLATER: lambda is characteristic root

- Eigenvalue of A: |A=lambdaI| = 0
- there are n eigenvalues for a matrix of order n

lambda is not necessarily unique
