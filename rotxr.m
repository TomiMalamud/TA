function Rx = rotxr(angulo)
% ángulos en radianes.
Rx = [1 0 0;...
      0 cos(angulo) -sin(angulo);...
      0 sin(angulo) cos(angulo)];
            
end