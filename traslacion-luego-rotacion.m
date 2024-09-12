close all; clear all; clc

p = [-2.00, -9.00, 0.00]; % Traslación
theta = 46; % Rotación alrededor de Y
ruvw = [-2.00, -5.00, -5.00 1]'; % Vector asociado a 0UVW

%% Matriz traslación
T = [eye(3) p';...
    0 0 0 1];

%% Matriz rotación
R = [roty(theta) [0; 0; 0];...
    0 0 0 1];

%% Traslación y después Rotación
T_R = R * T;% contraintuitivo pero es así

rxyz = T_R * ruvw
