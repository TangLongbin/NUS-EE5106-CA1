function coeff = CubicPoly(theta_0, theta_f, dtheta_0, dtheta_f, t_f)
% CubicPoly generates the coefficients of a cubic polynomial trajectory.
%
% Syntax:
%   coeff = CubicPoly(theta_0, theta_f, dtheta_0, dtheta_f, t_f)
%
% Inputs:
%   theta_0 - initial joint angle
%   theta_f - final joint angle
%   dtheta_0 - initial joint velocity
%   dtheta_f - final joint velocity
%   t_f - final time
%
% Outputs:
%   coeff - the coefficients of the cubic polynomial trajectory
%
% Example:
%   coeff = CubicPoly(0, pi/2, 0, 0, 1);
%   coeff = [0; 0; 4.7124; -3.1416]
% 
%   coeff = CubicPoly(0, 90, 0, 0, 1,);
%   coeff = [0; 0; 270; -180]
%
        
    % Calculate the coefficients
    A = [1, 0, 0, 0;
         0, 1, 0, 0;
         1, t_f, t_f^2, t_f^3;
         0, 1, 2*t_f, 3*t_f^2];
    b = [theta_0; dtheta_0; theta_f; dtheta_f];
    coeff = A \ b;
end
