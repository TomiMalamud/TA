close all; clear all; clc

p = [-2.00, -6.00, -3.00]; % Traslación
theta = 93; % Rotación alrededor de z
ruvw = [-8.00, -2.00, -9.00 1]'; % Vector asociado a 0UVW

%% Matriz traslación
T = [eye(3) p';...
    0 0 0 1];

%% Matriz rotación
R = [rotz(theta) [0; 0; 0];...
    0 0 0 1];


T_R = T*R;

rxyz = T_R * ruvw


