function Ry = rotyr(angulo)
% ángulos en radianes.
Ry = [cos(angulo) 0 sin(angulo);...
                   0 1 0;...
                -sin(angulo) 0 cos(angulo)];
                    
end