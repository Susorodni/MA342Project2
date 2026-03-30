clear; clc; close all;

lambda = 5;       % task arrival rate       [tasks/time]
mu     = 0.4;     % completion rate coeff   [1/time]
f      = 0.10;    % queue-management frac   [dimensionless]
alpha  = 0.15;    % load-balancing gain     [1/time]
tau    = 2.0;     % network delay           [time]
tspan  = [0, 60];

Q0    = [20; 5; 2];            % initial queue lengths (imbalanced)
Qstar = lambda / (mu*(1-f));   % analytical steady state

% 3-node ring: 1-2-3-1
A = [0 1 1; 1 0 1; 1 1 0];

colors = {'b','r','k'};
labels = {'Q_1','Q_2','Q_3'};

tau_values = [0.5, 2.0, 5.0, 10.0];
figure('Name','Tau Sweep');

for k = 1:4
    sol = dde23(@(t,Q,Qd) cloudDDE(t,Q,Qd,lambda,mu,f,alpha,A), ...
                tau_values(k), @(t) Q0, tspan);
    subplot(2,2,k);
    hold on;
    for i = 1:3
        plot(sol.x, sol.y(i,:), colors{i}, 'LineWidth', 1.5);
    end
    yline(Qstar, '--', 'Q^*', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.2);
    title(sprintf('\\tau = %.1f', tau_values(k)));
    xlabel('Time')
    ylabel('Queue Length')
    legend(labels{:}, 'Location','northeast');
    grid on;
end
sgtitle('Effect of Network Delay \tau (3-Node Ring)', 'FontWeight','bold');

alpha_values = [0.02, 0.08, 0.20, 0.50];
figure('Name','Alpha Sweep');

for k = 1:4
    sol = dde23(@(t,Q,Qd) cloudDDE(t,Q,Qd,lambda,mu,f,alpha_values(k),A), ...
                tau, @(t) Q0, tspan);
    subplot(2,2,k);
    hold on;
    for i = 1:3
        plot(sol.x, sol.y(i,:), colors{i}, 'LineWidth', 1.5);
    end
    yline(Qstar, '--', 'Q^*', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.2);
    title(sprintf('\\alpha = %.2f', alpha_values(k)));
    xlabel('Time'); ylabel('Queue Length');
    legend(labels{:}, 'Location','northeast');
    grid on;
end
sgtitle(sprintf('Effect of Load-Balancing Gain \\alpha (\\tau = %.1f)', tau), ...
        'FontWeight','bold');