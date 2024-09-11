%pkg load symbolic

syms l1 l4 real;
syms q1 d2 d3 q4 real;

%% Parámetros de D - H
q = [q1  pi/2 0 q4];
d = [l1 d2 d3 l4];
a = [0 0 0 0];
alfa = [0 pi/2 0 0];

%% Matrices de transformación homogénea
A01 = matrizDenavitHartenberg(q(1), d(1), a(1), alfa(1));
A12 = matrizDenavitHartenberg(q(2), d(2), a(2), alfa(2));
A23 = matrizDenavitHartenberg(q(3), d(3), a(3), alfa(3));
A34 = matrizDenavitHartenberg(q(4), d(4), a(4), alfa(4));

vpa(eval(A23),2)
