close all; clear all; clc

p = [-9.00, -1.00, -3.00]; % Traslación
theta = -163; % Rotación alrededor de x
ruvw = [-6.00, 0.00, -9.00 1]'; % Vector asociado a 0UVW

%% Matriz traslación
T = [eye(3) p';...
    0 0 0 1];

%% Matriz rotación
R = [rotx(theta) [0; 0; 0];...
    0 0 0 1];

%% Rotación y después Traslación
T_R = T*R; % contraintuitivo pero es así

rxyz = T_R * ruvw
