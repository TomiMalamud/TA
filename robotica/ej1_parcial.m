close all; clear all; clc

%% Constantes del robot

l = [7.70 4.90 4.50 2.50];
d4 = 2.0

%% Variables
q = deg2rad([45 45 -90 0 90 22.50]);

%% Párametros de D - H
theta = [q(1) q(2) q(3) 0 q(5) q(6)];
d = [l(1) 0 0 l(3)+d4 0 l(4)];
a = [0 l(2) 0 0 0 0];
alpha = [-pi/2 0 pi/2 -pi/2 pi/2 0];

%% Creación de las Matrices de transformación  homogénea
A01 = matrizDenavitHartenberg(theta(1), d(1), a(1), alpha(1));
A12 = matrizDenavitHartenberg(theta(2), d(2), a(2), alpha(2));
A23 = matrizDenavitHartenberg(theta(3), d(3), a(3), alpha(3));
A34 = matrizDenavitHartenberg(theta(4), d(4), a(4), alpha(4));
A45 = matrizDenavitHartenberg(theta(5), d(5), a(5), alpha(5));
A56 = matrizDenavitHartenberg(theta(6), d(6), a(6), alpha(6));

%% En la última columna se obtiene px, py y pz del efector final
T = A01 * A12 * A23 * A34 * A45 * A56
