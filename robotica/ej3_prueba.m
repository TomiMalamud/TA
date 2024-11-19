% Clear workspace and close all figures
close all; clear all; clc;

% Input parameters
theta1 = 37.00;  % Initial rotation around x
theta2 = -85.00; % Rotation around y
theta3 = 56.00;  % Final rotation around x
ruvw = [-3.00; -2.00; -5.00; 1]; % Vector associated with 0UVW

% Step 1: Create first rotation matrix around X
Rx1 = [1 0 0 0;
       0 cosd(theta1) -sind(theta1) 0;
       0 sind(theta1) cosd(theta1) 0;
       0 0 0 1];

% Step 2: Create rotation matrix around Y
Ry = [cosd(theta2) 0 sind(theta2) 0;
      0 1 0 0;
      -sind(theta2) 0 cosd(theta2) 0;
      0 0 0 1];

% Step 3: Create second rotation matrix around X
Rx2 = [1 0 0 0;
       0 cosd(theta3) -sind(theta3) 0;
       0 sind(theta3) cosd(theta3) 0;
       0 0 0 1];

% Step 4: Calculate total transformation
T_total = Rx2 * Ry * Rx1;

% Step 5: Transform the coordinates
rxyz = T_total * ruvw;

% Display intermediate results
disp('First rotation matrix around X (Rx1):');
disp(Rx1);
disp('Rotation matrix around Y (Ry):');
disp(Ry);
disp('Second rotation matrix around X (Rx2):');
disp(Rx2);
disp('Total transformation matrix (T_total):');
disp(T_total);

% Display final result
disp('Transformed coordinates (rxyz):');
disp(rxyz);

% Compare with built-in functions
Rx1_builtin = [rotx(theta1) [0; 0; 0]; 0 0 0 1];
Ry_builtin = [roty(theta2) [0; 0; 0]; 0 0 0 1];
Rx2_builtin = [rotx(theta3) [0; 0; 0]; 0 0 0 1];

disp('Difference between custom Rx1 and built-in rotx:');
disp(max(max(abs(Rx1 - Rx1_builtin))));

disp('Difference between custom Ry and built-in roty:');
disp(max(max(abs(Ry - Ry_builtin))));

disp('Difference between custom Rx2 and built-in rotx:');
disp(max(max(abs(Rx2 - Rx2_builtin))));

% Calculate using built-in functions (as in the original code)
T_total_builtin = Rx2_builtin * Ry_builtin * Rx1_builtin;
rxyz_builtin = T_total_builtin * ruvw;

disp('Transformed coordinates using built-in functions:');
disp(rxyz_builtin);

disp('Difference between custom and built-in results:');
disp(max(abs(rxyz - rxyz_builtin)));
