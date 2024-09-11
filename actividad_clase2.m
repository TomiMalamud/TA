close all; clear all; clc

r1= 54; % Rotación alrededor de Y
t1 = [-4 -7 -2]'; % Traslación
r2 = -17; % Rotación alrededor de Z
t2 =  [-8 -3 -8]';

%% Matriz de Transf Homogénea
T1 = [roty(r1) t1; 0 0 0 1];
T2 = [rotz(r2) t2; 0 0 0 1];

T = T2 * T1

ruvw = [-6 -3 -2 1]';
rxyz = T * ruvw

