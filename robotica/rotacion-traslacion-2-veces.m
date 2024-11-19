close all; clear all; clc

r1= -100; % Rotación alrededor de Y
t1 = [-7.00, -6.00, -5.00]'; % Traslación
r2 = -137; % Rotación alrededor de Z
t2 =  [-4.00, -9.00, -7.00]';

%% Matriz de Transf Homogénea
T1 = [roty(r1) t1; 0 0 0 1];
T2 = [rotz(r2) t2; 0 0 0 1];

T = T2 * T1

ruvw = [-1.00, -9.00, 0.00 1]';
rxyz = T * ruvw

