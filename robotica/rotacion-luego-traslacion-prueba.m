% Clear workspace and close all figures
clear all;
close all;
clc;

% Define the parameters
p = [-2.00, -6.00, -3.00];  % Translation
theta = 93;  % Rotation around z-axis (degrees)
ruvw = [-8.00; -2.00; -9.00; 1];  % Vector associated with 0UVW

% Create translation matrix
T = eye(4);
T(1:3, 4) = p';

% Create rotation matrix
R = eye(4);
R(1:3, 1:3) = rotz(theta);

% Combine translation and rotation
T_R = T * R;

% Calculate the transformed vector
rxyz = T_R * ruvw;

% Display results
disp('Transformed vector (rxyz):');
disp(rxyz);
disp('Individual components:');
fprintf('rx = %.6f\n', rxyz(1));
fprintf('ry = %.6f\n', rxyz(2));
fprintf('rz = %.6f\n', rxyz(3));
