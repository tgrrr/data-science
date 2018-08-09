proc iml;
reset print;

F = {
  4 0 0,
  0 9 0,
  0 0 1
};

F_transpose = T(F);

G = F * F_transpose;

G_eigenvalues = eigval(G);

G_eigenvector = eigvec(G);