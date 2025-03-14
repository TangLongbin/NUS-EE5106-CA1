function joint_type = JointType(theta_i, d_i)
% Determine the type of joints in a robot based on the DH parameters theta_i and d_i
%
% Syntax:
%   joint_type = JointType(theta_i, d_i)
%
% Inputs:
%   theta_i - angle of the joint
%   d_i - offset of the joint
%
% Outputs:
%   joint_type - type of the joint, 'revolute', 'prismatic' or 'fixed'
%
% Example:
%   joint_type = JointType(0, 0);
%   joint_type = 'fixed'
%
%   syms theta_1;
%   joint_type = JointType(theta_1, 0);
%   joint_type = 'revolute'
%
%   syms d_1;
%   joint_type = JointType(0, d_1);
%   joint_type = 'prismatic'

    % convert the joint parameters to strings
    theta_str = char(theta_i);
    d_str = char(d_i);

    % check if the joint is revolute or prismatic
    is_revolute = isa(theta_i, 'sym') && ~isempty(regexp(theta_str, '^theta_\d+$', 'once'));
    is_prismatic = isa(d_i, 'sym') && ~isempty(regexp(d_str, '^d_\d+$', 'once'));

    if is_revolute && ~is_prismatic
        joint_type = 'revolute';
    elseif ~is_revolute && is_prismatic
        joint_type = 'prismatic';
    elseif ~is_revolute && ~is_prismatic
        joint_type = 'fixed';
    else
        error('Invalid joint parameters');
    end
end