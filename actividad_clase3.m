close all; clear all; clc

r1 = -42; % eje Y
t1 = [-2 -2 -8]';

%% Matriz de Transf Homogénea
T = [roty(r1) t1; 0 0 0 1];
% Calculamos rxyz
ruvw = [-5 -5 -3 1]';
rxy = T * ruvw
