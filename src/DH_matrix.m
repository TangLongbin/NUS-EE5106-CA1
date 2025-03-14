function T = DH_matrix(theta, d, a, alpha, angle_unit)
% Calculates the homogeneous transformation matrix using Denavit-Hartenberg parameters.
%
% Syntax:
%   T = DH_matrix(a, alpha, d, theta)
%   T = DH_matrix(a, alpha, d, theta, angle_unit)
%
% Inputs:
%   a     - Link length (distance along x_i from z_{i-1} to z_i)
%   alpha - Link twist (angle about x_i from z_{i-1} to z_i)
%   d     - Link offset (distance along z_{i-1} from x_{i-1} to x_i)
%   theta - Joint angle (angle about z_{i-1} from x_{i-1} to x_i)
%   angle_unit - Unit of the angle (default: 'rad')
%
% Outputs:
%   T     - 4×4 homogeneous transformation matrix
%
% Example:
%   T = DH_matrix(0.5, pi/2, 0.3, pi/4);
%   T = DH_matrix(0.5, 90, 0.3, 45, 'deg');

    % Default angle unit
    if nargin < 5
        angle_unit = 'rad';
    end
    % Convert angles to radians if required
    if strcmp(angle_unit, 'deg')
        theta = deg2rad(theta);
        alpha = deg2rad(alpha);
    end
    % Calculate the cosine and sine
    c_theta = cos(theta);
    s_theta = sin(theta);
    c_alpha = cos(alpha);
    s_alpha = sin(alpha);
    % Calculate the homogeneous transformation matrix
    T = [c_theta, -s_theta*c_alpha, s_theta*s_alpha, a*c_theta;
    s_theta, c_theta*c_alpha, -c_theta*s_alpha, a*s_theta;
    0, s_alpha, c_alpha, d;
    0, 0, 0, 1];
end
