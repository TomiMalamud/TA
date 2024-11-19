close all; clear all; clc

p = [-4 -7 -5]; % Traslación
theta = 17; % Rotación alrededor de Z
ruvw = [-3 -3 -6 1]'; % Vector asociado a 0UVW

%% Matriz traslación
T = [eye(3) p';...
    0 0 0 1];

%% Matriz rotación
R = [rotz(theta) [0; 0; 0];...
    0 0 0 1];

%% Traslación seguida de Rotación
T_R = R * T;

rxyz = T_R * ruvw
