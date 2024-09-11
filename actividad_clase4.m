close all; clear all; clc

p = [-4 -4 -1]; % Traslación
theta = -69; % Rotación alrededor de Y
ruvw = [-2 -3 -6 1]'; % Vector asociado a 0UVW

%% Matriz traslación
T = [eye(3) p';...
    0 0 0 1];

%% Matriz rotación
R = [roty(theta) [0; 0; 0];...
    0 0 0 1];

%% Traslación seguida de Rotación
T_R = R * T;

rxyz = T_R * ruvw
