function arrow(position, target, varargin)
    % Argumentos por defecto
    linewidth = 1;
    color = 'b';

    % Procesar argumentos opcionales
    for i = 1:2:numel(varargin)
        if strcmp(varargin{i}, 'linewidth')
            linewidth = varargin{i + 1};
        elseif strcmp(varargin{i}, 'color')
            color = varargin{i + 1};
        end
    end

    % Dibujar la flecha
    quiver3(position(1), position(2), position(3), target(1) - position(1), target(2) - position(2),target(3) - position(3),...
    'LineWidth', linewidth,...
    'Color', color,...
    'MaxHeadSize', 1);

end
