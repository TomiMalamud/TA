close all; clear all; clc

p = [-4 -7 -2]; % Traslación
theta = -57; % Rotación alrededor de z
ruvw = [-7.00 -4.00 -3.00 1]'; % Vector asociado a 0UVW

%% Matriz traslación
T = [eye(3) p';...
    0 0 0 1];

%% Matriz rotación
R = [rotz(theta) [0; 0; 0];...
    0 0 0 1];

%% Rotación y después Traslación
T_R = T*R; % contraintuitivo pero es así

rxyz = T_R * ruvw
