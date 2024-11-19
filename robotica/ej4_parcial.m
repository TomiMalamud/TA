close all; clear all; clc

%% Parámetros del problema
theta1 = 37.00;  % Rotación inicial alrededor de x
theta2 = -85.00; % Rotación alrededor de y
theta3 = 56.00;  % Rotación final alrededor de x
ruvw = [-3.00; -2.00; -5.00; 1]; % Vector asociado a 0UVW

%% Matriz de rotación alrededor de X
Rx1 = [rotx(theta1) [0; 0; 0];
       0 0 0 1];

%% Matriz de rotación alrededor de Y
Ry = [roty(theta2) [0; 0; 0];
      0 0 0 1];

%% Matriz de rotación alrededor de X
Rx2 = [rotx(theta3) [0; 0; 0];
       0 0 0 1];

%% Transformación total
T_total = Rx2 * Ry * Rx1;

%% Cálculo de las coordenadas transformadas
rxyz = T_total * ruvw
