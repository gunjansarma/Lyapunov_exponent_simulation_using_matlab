function lyapunovExponentAnimationWithTrajectory
    % Parameters
    r_values = linspace(2.5, 4, 1000);
    num_iterations = 100;
    initial_condition = 0.5;

    % Preallocate arrays for Lyapunov exponents
    lyapunov_exponents = zeros(size(r_values));

    % Create a figure for the animation
    figure;

    % Loop through different values of r
    for i = 1:length(r_values)
        r = r_values(i);
        x = initial_condition;

        % Iterate the logistic map to get transient behavior
        for j = 1:100
            x = r * x * (1 - x);
        end

        sum_lyapunov = 0;

        % Iterate for calculating the Lyapunov exponent
        for j = 1:num_iterations
            x = r * x * (1 - x);
            sum_lyapunov = sum_lyapunov + log(abs(r - 2 * r * x));

            % Plot the trajectory
            plot(r, x, 'ob', 'MarkerSize', 2);
            hold on;
        end

        % Average over iterations
        lyapunov_exponents(i) = sum_lyapunov / num_iterations;

        % Plot the Lyapunov exponent values
        plot(r, lyapunov_exponents(i), 'or', 'MarkerSize', 5);
        xlabel('r');
        ylabel('Lyapunov Exponent');
        title('Lyapunov Exponent Animation with Trajectory');
        grid on;

        % Pause to control the animation speed
        pause(0.01);

        % Clear the previous plot
        hold off;
    end
end
