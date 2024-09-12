# Ejercicios de Tecnología para la Automatización

En el primer parcial se toma Rotaciones y Traslaciones y el algoritmo de Denavit - Hartenberg.

Este repositorio tiene los 3 scripts de octave que hacen falta para cada caso. Son 3 tipos de ejercicio:

## 1. Traslación y Luego Rotación

Son del tipo:
> Un sistema OUVW ha sido **trasladado** un vector p = (-2.00, -9.00, 0.00) con respecto al sistema 0XYZ, y **posteriormente girado** 46.00º alrededor del eje 0Y.

O sea, primero se traslada y luego se rota (o se gira, es lo mismo). La clave está en que el orden es: `R * T`


```matlab
close all; clear all; clc

p = [-2.00, -9.00, 0.00]; % Traslación
theta = 46; % Rotación alrededor de Y
ruvw = [-2.00, -5.00, -5.00 1]'; % Vector asociado a 0UVW. Siempre va 1 al final

%% Matriz traslación
T = [eye(3) p';...
    0 0 0 1];

%% Matriz rotación
R = [roty(theta) [0; 0; 0];...
    0 0 0 1];

%% Traslación y después Rotación
T_R = R * T;% contraintuitivo pero es así

rxyz = T_R * ruvw
```


## 2. Rotación y Luego Traslación

Son del tipo:
> Un sistema OUVW ha sido **girado** -163.00º alrededor del eje 0X, y **posteriormente trasladado** un vector p = (-9.00, -1.00, -3.00) con respecto al sistema 0XYZ.


O sea, primero se rota y luego se traslada.
**La clave está en que el orden es: `T * R`**. La `T` va antes que la `R`.


```matlab
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
T_R = T * R; % contraintuitivo pero es así

rxyz = T_R * ruvw

```

## 3. Doble rotación y traslación

Son del tipo:
> Un sistema OUVW ha sido girado 100.00º alrededor del eje 0X,y posteriormente trasladado un vector p1 = (-5.00, -5.00, -6.00), y luego ha sido girado -4.00º alrededor del eje 0Z y trasladado un vector p2 = (-4.00, -4.00, -1.00) con respecto al sistema 0XYZ.

En este caso se toman los mismos conceptos que en los casos anteriores. El código común para este caso es el siguiente:

```matlab
close all; clear all; clc

r1= 100; % Rotación alrededor de X
t1 = [-5.00, -5.00, -6.00]'; % Traslación
r2 = -4; % Rotación alrededor de Z
t2 =  [-4.00, -4.00, -1.00]';

%% Matriz de Transf Homogénea
T1 = [rotx(r1) t1; 0 0 0 1]; % rotx para rotación alrededor de 0X
T2 = [rotz(r2) t2; 0 0 0 1]; % rotz para rotación alrededor de 0Z

T = T2 * T1

ruvw = [-6 -3 -2 1]';
rxyz = T * ruvw
```