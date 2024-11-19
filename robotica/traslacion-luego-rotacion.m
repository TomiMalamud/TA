close all; clear all; clc

p = [-4.00, -7.00, -5.00]; % Traslación
theta = 17; % Rotación alrededor de Z
ruvw = [-3.00, -3.00, -6.00 1]'; % Vector asociado a 0UVW

%% Matriz traslación
T = [eye(3) p';...
    0 0 0 1];

%% Matriz rotación
R = [rotz(theta) [0; 0; 0];...
    0 0 0 1];

%% Traslación y después Rotación
T_R = R * T;% contraintuitivo pero es así

rxyz = T_R * ruvw
