

% Set up parameters
tspan = 0:0.01:50;  % Time span
x0 = [1, 0, 20];    % Initial conditions

% Integrate the system using ode45
[t, x] = ode45(@lorenz, tspan, x0);

% Perturb the initial conditions slightly
epsilon = 1e-6;
x_perturbed = x0 + epsilon * randn(size(x0));

% Integrate the perturbed system
[t_perturbed, x_perturbed] = ode45(@lorenz, tspan, x_perturbed);

% Calculate the distance between the trajectories
distances = sqrt(sum((x - x_perturbed).^2, 2));

% Calculate the largest Lyapunov exponent
lyapunov_exponent = mean(log(distances(2:end) ./ distances(1:end-1)));

% Plot the trajectories and the Lyapunov exponent
figure;
subplot(2, 1, 1);
plot3(x(:, 1), x(:, 2), x(:, 3), 'b');
hold on;
plot3(x_perturbed(:, 1), x_perturbed(:, 2), x_perturbed(:, 3), 'r');
title('Trajectories');

subplot(2, 1, 2);
plot(t(2:end), log(distances(2:end) ./ distances(1:end-1)), 'k');
hold on;
plot(t, lyapunov_exponent * ones(size(t)), 'r--');
title('Lyapunov Exponent');

xlabel('Time');
ylabel('Logarithmic Divergence');
legend('Lyapunov Exponent', 'Location', 'Best');

hold off;

% Define your dynamical system (example: the Lorenz system)
function dxdt = lorenz(t, x)
    sigma = 10;
    beta = 8/3;
    rho = 28;
    
    dxdt = zeros(3, 1);
    dxdt(1) = sigma * (x(2) - x(1));
    dxdt(2) = x(1) * (rho - x(3)) - x(2);
    dxdt(3) = x(1) * x(2) - beta * x(3);
end

