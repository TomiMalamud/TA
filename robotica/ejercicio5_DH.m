close all; clear all; clc

%% Constantes del robot
%% La variable esc se utiliza para poder ver bien
%% en el gráfico los sistemas de coordenadas

esc = 0.01;
l = [656 495 334 184].*esc;
T = 5*esc;
S = 56.5*esc;

%% Variables
%% Se inicializa todos los thetas en 0°
%% Sistema en reposo

q = deg2rad([0 0 0 0 0]);

%% Párametros de D - H
theta = [q(1) q(2) q(3) q(4)+pi/2 q(5)];
d = [l(1) 0 -S 0 l(4)];
a = [-T l(2) l(3) 0 0]
alpha = [pi/2 0 0 pi/2 0]

%% Creación de las Matrices de transformación  homogénea
A01 = matrizDenavitHartenberg(theta(1), d(1), a(1), alpha(1));
A12 = matrizDenavitHartenberg(theta(2), d(2), a(2), alpha(2));
A23 = matrizDenavitHartenberg(theta(3), d(3), a(3), alpha(3));
A34 = matrizDenavitHartenberg(theta(4), d(4), a(4), alpha(4));
A45 = matrizDenavitHartenberg(theta(5), d(5), a(5), alpha(5));
T = A01 * A12 * A23 * A34 * A45

%% Dibujar el robot

%% NOTA: Recordar en el archivo dibujarSistemasDeEjesCoordenadosDeRobot se debe
%% comentar la linea 8

%% El vector TT se crea con el sistema de coordenadas en 0 y se va agregando
%% las Matrices de transformación homogénea

TT(:,:,1) = eye(4);
TT(:,:,2) = A01;
TT(:,:,3) = A01 * A12;
TT(:,:,4) = A01 * A12 * A23;
TT(:,:,5) = A01 * A12 * A23 * A34;
TT(:,:,6) = A01 * A12 * A23 * A34 * A45;
dibujarSistemasDeEjesCoordenadosDeRobot(TT);

%% Gráfico para theta con diferentes valores
%% Esto son los cambios para comparar con los valores en el pizarrón
q1 = deg2rad([-32.5 15.23 -7.5 0.2 180]);

%% Cambiar los valores del vector thetha
theta = [q1(1) q1(2) q1(3) q1(4)+pi/2 q1(5)];

%% Creación de la Matrices de transformación  homogénea para T1
B01 = matrizDenavitHartenberg(theta(1), d(1), a(1), alpha(1));
B12 = matrizDenavitHartenberg(theta(2), d(2), a(2), alpha(2));
B23 = matrizDenavitHartenberg(theta(3), d(3), a(3), alpha(3));
B34 = matrizDenavitHartenberg(theta(4), d(4), a(4), alpha(4));
B45 = matrizDenavitHartenberg(theta(5), d(5), a(5), alpha(5));
T1 = B01 * B12 * B23 * B34 * B45

