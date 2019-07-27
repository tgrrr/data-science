## 5 - Factor Analysis

totalsF1Estimated = 0.602 + 0.467 + 0.926 + 1.000 + 0.874 + 0.894;
totalsF2Estimated = 0.200 + 0.154 + 0.143 + 0.000 + 0.476 + 0.327;
totalsF1Rotated = 0.484 + 0.375 + 0.603 + 0.519 + 0.861 + 0.744;
totalsF2Rotated = 0.411 + 0.319 + 0.717 + 0.855 + 0.499 + 0.594;
print totalsF1Estimated;
print totalsF2Estimated;
print totalsF1Rotated;
print totalsF2Rotated;

#### Varimax-rotated-loadings

|  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- |
|  |  | F1* | F1*Proportions | F2* | F2*Proportions |
| Skull length | 1 | 0.484 | 0.134969325 | 0.411 | 0.121060383 |
| Skull breadth | 2 | 0.375 | 0.104573341 | 0.319 | 0.093961708 |
| Femur length | 3 | 0.603 | 0.168153932 | 0.717 | 0.211192931 |
| Tibia length | 4 | 0.519 | 0.144729504 | 0.855 | 0.251840943 |
| Humerus length | 5 | 0.861 | 0.24010039 | 0.499 | 0.146980854 |
| Ulna length | 6 | 0.744 | 0.207473508 | 0.594 | 0.174963181 |
| **Totals** |  | 3.586 |  | 3.395 |  |


| Skeletal Feature | Variable | Estimated- | -Loadings | Varimax- | -rotated-loadings |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|  |  | F1 | F1 Proportions | F2 | F2 Proportions | F1* | F1*Proportions | F2* | F2*Proportions |
| Skull length | 1 | 0.602 | 0.1263909 | 0.200 | 0.0419903 | 0.484 | 0.134969325 | 0.411 | 0.121060383 |
| Skull breadth | 2 | 0.467 | 0.0980474 | 0.154 | 0.0323326 | 0.375 | 0.104573341 | 0.319 | 0.093961708 |
| Femur length | 3 | 0.926 | 0.1944153 | 0.143 | 0.0300231 | 0.603 | 0.168153932 | 0.717 | 0.211192931 |
| Tibia length | 4 | 1.000 | 0.2099517 | 0.000 | 0 | 0.519 | 0.144729504 | 0.855 | 0.251840943 |
| Humerus length | 5 | 0.874 | 0.1834978 | 0.476 | 0.099937 | 0.861 | 0.24010039 | 0.499 | 0.146980854 |
| Ulna length | 6 | 0.894 | 0.1876968 | 0.327 | 0.0686542 | 0.744 | 0.207473508 | 0.594 | 0.174963181 |
| **Totals** |  | 4.763 |  | 1.3 |  | 3.586 |  | 3.395 |  |

.2/3.586

estimatedFactorLoading = {
0.602 0.200,
0.467 0.154,
0.926 0.143,
1.000 0.000,
0.874 0.476,
0.894 0.327
};


0.0300231
0.0
0.099937
0.0686542

The correlation matrix below is from the measurement of skeletal features of white leghorn fowl (Dunn, Storrs Agricultural Experimental Station Bulletin, 52, 1928). Where

X<sub>1</sub> = Skull length<br />
X<sub>2</sub> = Skull breadth <br />
X<sub>3</sub> = Femur length <br />
X<sub>4</sub> = Tibia length <br />
X<sub>5</sub> = Humerus length  <br />
X<sub>6</sub> = Ulna length <br />

R = {
1.000 0.505 0.569 0.602 0.621 0.603,
0.505 1.000 0.422 0.467 0.482 0.450,
0.569 0.422 1.000 0.926 0.877 0.878,
0.602 0.467 0.926 1.000 0.874 0.894,
0.621 0.482 0.877 0.874 1.000 0.937,
0.603 0.450 0.878 0.894 0.937 1.000,
};

0.0419903
0.0323326
0.0300231
0.0
0.099937
0.0686542

Using the **maximum likelihood procedure** the following estimated factor loadings were extracted:

estimatedFactorLoading = {
0.602 0.200,
0.467 0.154,
0.926 0.143,
1.000 0.000,
0.874 0.476,
0.894 0.327,
}

#### d) Using the **unrotated estimated factor** loadings, obtain the maximum likelihood estimates of the following:
#### i. The specific variances. 

LL + Y = 

| 1 | 0.602 | 0.200 | 0.484 | 0.411 |
| --- | --- | --- | --- | --- |
| 2 | 0.467 | 0.154 | 0.375 | 0.319 |
| 3 | 0.926 | 0.143 | 0.603 | 0.717 |
| 4 | 1.000 | 0.000 | 0.519 | 0.855 |
| 5 | 0.874 | 0.476 | 0.861 | 0.499 |
| 6 | 0.894 | 0.327 | 0.744 | 0.594 |



#### ii. The communalities.

#### iii. The proportion of variance explained by each factor. 

#### iv. Theresidualmatrix `R−LˆLˆ′−Ψˆ`
(2.5 marks)
  


#### e) Using the varimax rotated estimated factor loadings, obtain the maximum likelihood estimates of the following:

#### i. The specific variances. 

#### ii. The communalities.

#### iii. The proportion of variance explained by each factor. 

#### iv. Theresidualmatrix `R−LˆLˆ′−Ψˆ` (2.5 marks)

#### f) Comment on the results using the two loading methods by comparing your results from  part a) and part b) above. (2 marks)