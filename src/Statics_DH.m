function tau = Statics_DH(DH_params, q, F)
% Statics_DH calculates the static forces and torques acting on the joints of a robot manipulator.
%
% Syntax:
%   tau = Statics_DH(DH_params, q, F)
%
% Inputs:
%   DH_params - Denavit-Hartenberg parameters of the manipulator
%   DH_params(i,:) = [theta_i, d_i, a_i, alpha_i]
%   q - joint angles and positions of the manipulator
%   F - the forces and moments that the end-effector applies to the environment
%
% Outputs:
%   tau - the static forces and torques acting on the joints of the manipulator
%
% Example:
%   syms theta_1 d_2 d_3 l_1
%   DH_params = [theta_1, l_1, 0,         0;
%              sym(pi/2), d_2, 0, sym(pi/2);
%                      0, d_3, 0,        0];
%   q = [0; 1; 1]; % theta_1 = 0, d_2 = 1, d_3 = 1
%   F = [1; 2; 3; 0; 0; 0];
%   tau = Statics_DH(DH_params, q, F);
%   tau = [3; 2; 1]
%
    % Get the Jacobian matrix
    J = Jacobian_DH(DH_params);

    % Calculate the static forces and torques (symbolic computation)
    tau = J' * F;

    % Substitute the joint variables with the given joint angles and positions
    vars = SortedJointVar(DH_params);
    tau = subs(tau, vars, q);
    
end

