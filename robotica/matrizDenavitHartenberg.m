function A = matrizDenavitHartenberg(q,d,a,alfa)
% Angulos expresados en radianes.

A=[[cos(q) -sin(q) * cos(alfa)  sin(q) * sin(alfa) a * cos(q)]
   [sin(q)  cos(q) * cos(alfa) -cos(q) * sin(alfa) a * sin(q)]
   [0        sin(alfa)            cos(alfa)           d]
   [0        0                     0                    1]];
end
