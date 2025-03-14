function J = Jacobian_DH(DH_params, angle_unit)
% Calculates the Jacobian matrix of a manipulator using Denavit-Hartenberg parameters.
%
% Syntax:
%   J = Jacobian_DH(DH_params)
%   J = Jacobian_DH(DH_params, angle_unit)
%
% Inputs:
%   DH_params - Denavit-Hartenberg parameters of the manipulator
%   DH_params(i,:) = [theta_i, d_i, a_i, alpha_i]
%   angle_unit - unit of the angles in DH_params, 'rad' or 'deg'
%
% Outputs:
%   J - Jacobian matrix of the manipulator
%
% Example:
%   DH_params = [0, 0, 0, 0;
%                pi/2, 0, 0, pi/2;
%                0, 0, 1, 0;
%                0, 1, 0, 0];
%   J = Jacobian_DH(DH_params);
%
%   DH_params = [0, 0, 0, 0;
%                90, 0, 0, 90;
%                0, 0, 1, 0;
%                0, 1, 0, 0];
%   J = Jacobian_DH(DH_params, 'deg');

    if nargin < 2
        angle_unit = 'rad';  % default unit is radians
    end

    % Initialize numeric arrays for numeric computation
    n = size(DH_params, 1);  % number of joints
    p = zeros(3, n+1);            % joint positions
    z = repmat([0;0;1], 1, n+1);  % z-axis vectors of the joints
    T = eye(4);                   % initialize transformation matrix
    J_v = zeros(3, n);            % linear velocity part of the Jacobian
    J_omega = zeros(3, n);        % angular velocity part of the Jacobian

    % Check if there are symbolic variables in DH_params    
    if  ~isempty(symvar(DH_params))
        % Convert the numeric arrays to symbolic arrays
        p = sym(p);
        z = sym(z);
        T = sym(T);
        J_v = sym(J_v);
        J_omega = sym(J_omega);
    end

    % Calculate the transformation matrices and joint positions
    for i = 1:n
        A = DH_matrix(DH_params(i, 1), DH_params(i, 2), DH_params(i, 3), DH_params(i, 4), angle_unit);
        T = T * A;  % calculate T_i_{i-1}
        p(:, i+1) = T(1:3, 4);  % store the joint position
        z(:, i+1) = T(1:3, 3);  % store the z-axis vector
    end

    % calculate the Jacobian matrix
    p_n = p(:, end);  % position of the end-effector
    for i = 1:n
        % get the joint type
        theta_i = DH_params(i,1);
        d_i = DH_params(i,2);
        joint_type = JointType(theta_i, d_i);
        
        % calculate the Jacobian matrix for different joint types
        if strcmp(joint_type, 'revolute')  % revolute joints
            J_v(:, i) = cross(z(:, i), (p_n - p(:, i)));
            J_omega(:, i) = z(:, i);
        elseif strcmp(joint_type, 'prismatic')  % prismatic joints
            J_v(:, i) = z(:, i);
            J_omega(:, i) = [0; 0; 0];
        end
    end

    J = [J_v; J_omega];  % Jacobian matrix
end
