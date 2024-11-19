close all; clear all; clc

%% Parámetros del problema
theta1 = -171.00; % Rotación inicial alrededor de z
p = [-5.00, -6.00, -8.00]'; % Vector de traslación
theta2 = -115.00; % Rotación final alrededor de y
ruvw = [-5.00, -9.00, -4.00, 1]'; % Vector asociado a 0UVW

%% Matriz rotación alrededor de Z
Rz = [rotz(theta1) [0, 0, 0]';
      0 0 0 1];

%% Matriz traslación
T = [eye(3) p;
     0 0 0 1];

%% Matriz rotación alrededor de Y
Ry = [roty(theta2) [0, 0, 0]';
      0 0 0 1];

%% Transformación total
T_total = Ry * T * Rz;

%% Cálculo de las coordenadas transformadas
rxyz = T_total * ruvw

