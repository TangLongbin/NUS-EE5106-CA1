function [coeff, t_seg] = CubicPlanning(constraints)
% CubicPlanning generates the coefficients of a cubic polynomial trajectory.
%
% Syntax:
%   coeff, t_seg = CubicPlanning(constraints)
%
% Inputs:
%   constraints - the constraints of the trajectory
%   constraints(i,:) = [theta_0, theta_f, dtheta_0, dtheta_f, t_f]
%
% Outputs:
%   coeff - the coefficients of the cubic polynomial trajectory
%   t_seg - the time duration of each segment
%
% Example:
%   constraints = [   0, pi/2,   0, pi, 1;
%                  pi/2,    pi, pi,  0, 1];
%   [coeff, t_seg] = CubicPlanning(constraints);
%   coeff = [     0,      0,  1.5708, 0;
%            1.5708, 3.1416, -1.5708, 0]
%   t_seg = [1, 1]
%
%   constraints = [ 0,  90,   0, 180, 1;
%                  90, 180, 180,   0, 1];
%   [coeff, t_seg] = CubicPlanning(constraints);
%   coeff = [ 0,   0,  90, 0;
%            90, 180, -90, 0]
%   t_seg = [1, 1]
%

    % Get the number of segments
    n = size(constraints, 1);

    % Initialize the coefficients and time duration
    coeff = zeros(n, 4);
    t_seg = zeros(n, 1);

    % Convert the coeff and t_seg to symbolic if constraints contain symbolic values
    if isa(constraints, 'sym')
        coeff = sym(coeff);
        t_seg = sym(t_seg);
    end

    % Calculate the coefficients for each segment
    for i = 1:n
        theta_0 = constraints(i, 1);
        theta_f = constraints(i, 2);
        dtheta_0 = constraints(i, 3);
        dtheta_f = constraints(i, 4);
        t_f = constraints(i, 5);
        coeff(i,:) = CubicPoly(theta_0, theta_f, dtheta_0, dtheta_f, t_f);
        t_seg(i) = t_f;
    end
end