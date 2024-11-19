function dibujarSistemasDeEjesCoordenadosDeRobot(TT)
%figure('Renderer', 'OpenGL');
persistent fig
if isempty(fig)
    fig = figure;
end
%figure
%cla(fig,'reset')
set(gca, 'FontSize', 12);
axis([-2 2 -2 2 -2 2])
xlabel('x'); ylabel('y'); zlabel('z')
hold on; grid on
dim =size(TT);
for i=1:dim(end)
    posicion = [TT(1,4,i) TT(2,4,i) TT(3,4,i)]';
    rotacion = TT(1:3, 1:3,i);
    arrow(posicion, rotacion(:,1)+posicion, 'linewidth',2,'color','r');
    arrow(posicion, rotacion(:,2)+posicion, 'linewidth',2,'color','b');
    arrow(posicion, rotacion(:,3)+posicion, 'linewidth',2,'color','g');

    text(rotacion(1,1) + posicion(1), rotacion(2,1) + posicion(2), rotacion(3,1) + posicion(3), sprintf('X_%d',i-1),'FontSize', 12)
    text(rotacion(1,2) + posicion(1), rotacion(2,2) + posicion(2), rotacion(3,2) + posicion(3), sprintf('Y_%d',i-1 ),'FontSize', 12)
    text(rotacion(1,3) + posicion(1), rotacion(2,3) + posicion(2), rotacion(3,3) + posicion(3), sprintf('Z_%d',i-1),'FontSize', 12)

    % Agregar texto en i = 1
    if i == 1
        text(posicion(1)+0.05, posicion(2)+0.05, posicion(3)+0.05, 'Base del robot', 'FontSize', 12);
    end
    % Agregar l�neas para los eslabones
    if i > 1
        % Conectar el sistema de ejes actual con el anterior
        posicion_anterior = [TT(1,4,i-1) TT(2,4,i-1) TT(3,4,i-1)]';
        line([posicion_anterior(1), posicion(1)], [posicion_anterior(2), posicion(2)], [posicion_anterior(3), posicion(3)],...
            'Color', 'k',...
            'LineWidth', 2,...
            'LineStyle', '-.');
    end
    if i == length(TT)
        text(posicion(1)+0.05, posicion(2)+0.05, posicion(3)+0.05, 'TCP', 'FontSize', 12);
    end
end

view(30,30)
axis auto
axis equal
end

