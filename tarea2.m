% Supresión de la salida en la ventana de comandos
ocultar_salida = @(x) evalc(x);

% varBoolPrimera: booleana, inicializada en True
ocultar_salida('varBoolPrimera = true;');

% varBoolSegunda: booleana, inicializada en False
ocultar_salida('varBoolSegunda = false;');

% varBoolVector: array de 3 variables booleanas [True, False, False]
ocultar_salida('varBoolVector = [true, false, false];');

% varNumRealx: double, inicializada en 2.53
ocultar_salida('varNumRealx = 2.53;');

% varNumRealy: double, inicializada en -pi
ocultar_salida('varNumRealy = -pi;');

% varNumVectz: array de 4 variables doubles [10, 20, 30, 40]
ocultar_salida('varNumVectz = [10, 20, 30, 40];');

% varNumVectw: array de 100 variables doubles, de 0 a 99 en incrementos de 1
ocultar_salida('varNumVectw = 0:99;');

% varNumImagx: double compleja, inicializada en 3 + 4i
ocultar_salida('varNumImagx = 3 + 4i;');

% varMatrix: matriz 3x3 con valores específicos
ocultar_salida('varMatrix = [1, 4, 7; 2, 5, 8; 3, 6, 9];');

% varMatrixT: transpuesta de varMatrix
ocultar_salida('varMatrixT = varMatrix'';');

% varMatrixIdentidad: matriz identidad 6x6
ocultar_salida('varMatrixIdentidad = eye(6);');

% varCharArray: array de caracteres con la leyenda "Hola Mundo!"
ocultar_salida('varCharArray = "Hola Mundo!";');


