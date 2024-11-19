function prueba()
    % Robot parameters
    l = [7.70 4.90 4.50 2.50];
    d4 = 2.0;

    % Given joint angles
    q_deg = [45 45 -90 0 90 22.50];
    q = deg2rad(q_deg);

    % Calculate forward kinematics
    T = forwardKinematics(q, l, d4);

    % Extract TCP position
    calculated_pos = T(1:3, 4)';

    % Print results
    fprintf('Joint angles: [%.2f, %.2f, %.2f, %.2f, %.2f, %.2f]\n', q_deg);
    fprintf('Calculated TCP position: [%.4f, %.4f, %.4f]\n', calculated_pos);

    % You should replace these values with the expected TCP position
    expected_pos = [0.45 0.45 10.5991];  % Replace with your expected values

    if ~isequal(expected_pos, [0, 0, 0])  % Only compare if expected values are provided
        diff = norm(calculated_pos - expected_pos);
        fprintf('Expected TCP position:  [%.4f, %.4f, %.4f]\n', expected_pos);
        fprintf('Difference:             %.6f\n\n', diff);

        if diff < 1e-4
            fprintf('TCP position VERIFIED ✓\n');
        else
            fprintf('TCP position MISMATCH ✗\n');
        end
    else
        fprintf('\nNote: Replace [0, 0, 0] with your expected TCP position to enable verification.\n');
    end
end

function T = forwardKinematics(q, l, d4)
    % D-H parameters
    theta = q;
    d = [l(1) 0 0 l(3)+d4 0 l(4)];
    a = [0 l(2) 0 0 0 0];
    alpha = [-pi/2 0 pi/2 -pi/2 pi/2 0];

    % Calculate transformation matrices
    T = eye(4);
    for i = 1:6
        T = T * dh_matrix(theta(i), d(i), a(i), alpha(i));
    end
end

function A = dh_matrix(theta, d, a, alpha)
    A = [cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta);
         sin(theta)  cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
         0           sin(alpha)             cos(alpha)            d;
         0           0                      0                     1];
end
