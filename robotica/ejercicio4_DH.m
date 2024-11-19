close all; clear all; clc

%% Constantes del robot
l = [5 0 0 1];

%% Variables
%% Se inicializa todos los thetas en 0°
%% Sistema en reposo

q = [0 0 0 0];

%% Párametros de D - H
theta = [q(1) pi/2 0 q(4)];
d = [l(1) 0 0 l(4)];
a = [0 0 0 0]
alpha = [0 pi/2 0 0]

%% Creación de las Matrices de transformación  homogénea
A01 = matrizDenavitHartenberg(theta(1), d(1), a(1), alpha(1));
A12 = matrizDenavitHartenberg(theta(2), d(2), a(2), alpha(2));
A23 = matrizDenavitHartenberg(theta(3), d(3), a(3), alpha(3));
A34 = matrizDenavitHartenberg(theta(4), d(4), a(4), alpha(4));
T = A01 * A12 * A23 * A34

%% Dibujar el robot
%% El vector TT se crea con el sistema de coordenadas en 0 y se va agregando
%% las Matrices de transformación homogénea

TT(:,:,1) = eye(4);
TT(:,:,2) = A01;
TT(:,:,3) = A01 * A12;
TT(:,:,4) = A01 * A12 * A23;
TT(:,:,5) = A01 * A12 * A23 * A34;
dibujarSistemasDeEjesCoordenadosDeRobot(TT);
