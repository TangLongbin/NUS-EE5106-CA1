function PlotCubicTrajectory(coeff, t_seg)
% PlotCubicTrajectory plots the cubic polynomial trajectory.
%
% Syntax:
%   PlotCubicTrajectory(coeff, t_seg)
%
% Inputs:
%   coeff - the coefficients of the cubic polynomial trajectory
%   t_seg - the time duration of each segment
%
% Example:
%   coeff = [0.3491,         0,    0.2182,   -0.0436;
%            0.8727,    0.3491,   -0.1745,    0.0654;
%            1.3963,    0.4363,   -0.1745,    0.0218];
%   t_seg = [2, 2, 2];
%   PlotCubicTrajectory(coeff, t_seg);
%
    % Check if the dimensions of coeff and t_seg are consistent
    if size(coeff, 1) ~= length(t_seg)
        error('Dimensions of coeff and t_seg are inconsistent');
    end

    % Get the number of segments
    n = size(coeff, 1);
    via_points = zeros(n, 2);
    t_start = 0;

    % Plot the cubic polynomial trajectory
    figure("Name", "Cubic Polynomial Path");
    legendInfo = cell(1, n+3);
    hold on;
    for i = 1:n
        % Get the coefficients of the current segment
        a0 = coeff(i, 1); a1 = coeff(i, 2); a2 = coeff(i, 3); a3 = coeff(i, 4);

        % Generate the trajectory of the current segment
        t = linspace(0, t_seg(i), t_seg(i)*100);
        theta = a0 + a1*t + a2*t.^2 + a3*t.^3;

        % Plot the trajectory
        plot(t + t_start, theta, 'LineWidth', 2);
        legendInfo{i} = ['Segment ' num2str(i)];

        % Store the via points
        via_points(i, 1) = t_seg(i) + t_start;
        via_points(i, 2) = theta(end);

        % Update the start time for the next segment
        t_start = t_start + t_seg(i);

    end

    % Plot the start and end points
    plot(0, coeff(1, 1), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'black');
    plot(via_points(1:end-1, 1), via_points(1:end-1, 2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    plot(via_points(end, 1), via_points(end, 2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'green');
    text(0, coeff(1, 1), ['Angle: ', num2str(coeff(1, 1))], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
    text(via_points(:, 1), via_points(:, 2), compose("Angle: %.4f", via_points(:, 2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    legendInfo{n+1} = 'Start Point';
    legendInfo{n+2} = 'Via Points';
    legendInfo{n+3} = 'End Point';

    % Set the plot properties
    xlabel('Time (s)');
    ylabel('Theta (rads)');
    title('Cubic Polynomial Path');
    grid on;
    legend(legendInfo);
    hold off;
end
