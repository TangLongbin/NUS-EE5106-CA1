function vars = SortedJointVar(DH_params)
% Get all symbolic variables in DH_params, which are sorted by the joint number.
%
% Syntax:
%   vars = SortedJointVar(DH_params)
%
% Inputs:
%   DH_params - Denavit-Hartenberg parameters of the manipulator
%   DH_params(i,:) = [theta_i, d_i, a_i, alpha_i]
%
% Outputs:
%   vars - the symbolic variables in DH_params sorted by the joint number
%
% Example:
%   syms theta_1 d_2 d_3 l_1
%   DH_params = [theta_1, l_1, 0,         0;
%              sym(pi/2), d_2, 0, sym(pi/2);
%                      0, d_3, 0,        0];
%   vars = SortedJointVar(DH_params);
%   vars = ["theta_1", "d_2", "d_3"]

    % get all symbolic variables in DH_params
    vars = symvar(DH_params);

    % convert the symbolic variables to strings
    var_names = string(vars);

    % extract the theta_i and d_i variables
    theta_vars = var_names(~cellfun(@isempty, regexp(var_names, '^theta_\d+$')));
    d_vars = var_names(~cellfun(@isempty, regexp(var_names, '^d_\d+$')));

    % extract the indices of the variables
    theta_indices = double(extractAfter(theta_vars, "theta_"));
    d_indices = double(extractAfter(d_vars, "d_"));

    % sort the indices
    [~, theta_order] = sort(theta_indices);
    [~, d_order] = sort(d_indices);

    % combine the sorted variables
    vars = [theta_vars(theta_order), d_vars(d_order)];

    % convert the variables to symbolic variables
    vars = sym(vars);
end