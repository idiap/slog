Similarity Learning on Graph (SLOG) contains implementation of similarity learning methods
over relational data, where the relation between data points are given explicitly. 

The methods in the package divide into the following categories: 1) Link-based or
relational based only methods 2) Latent space model 3) Joint similarity learning on multi
relational data 4) Iterative ranking on relational data 5) Multi object similarity
learning 6) structured latent space models.

The usage of each function is shown in the SampleCode.m . 

Edges are represented by a matrix n*3 that n is number of Edges and each row is:
e1 e2 w

where e1 and e2 are the index of the first node and second node respectively. w is the
weight of the edge .

Nodes' features are shown by a sparse matrix X, m*d, in which m is number of objects and
d is number of features.


Please feel free to contact me at majid.yazdaani@gmail.com
