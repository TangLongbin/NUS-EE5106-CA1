function T_inv = InverseTransformation(T)
% Calculates the inverse of a homogeneous transformation matrix.
%
% Syntax:
%   T_inv = InverseTransformation(T)
%
% Inputs:
%   T - 4×4 homogeneous transformation matrix
%
% Outputs:
%   T_inv - Inverse of the homogeneous transformation matrix
%
% Example:
%   T = [1, 0, 0, 0;
%        0, 1, 0, 0;
%        0, 0, 1, 0;
%        0, 0, 0, 1];
%   T_inv = InverseTransformation(T);

    % Extract the rotation matrix and translation vector
    R = T(1:3, 1:3);
    p = T(1:3, 4);
    
    % Calculate the inverse of the rotation matrix
    R_inv = R';
    
    % Calculate the inverse of the translation vector
    p_inv = -R_inv * p;
    
    % Calculate the inverse of the homogeneous transformation matrix
    T_inv = [R_inv, p_inv;
             0, 0, 0, 1];
end