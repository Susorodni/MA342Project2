%% MA342 Project 2 SIR Model
clear variables;
close all;
clc;

tau = 10;
lags = tau;
sir0 = [30E06, 30, 28];

function sirp = ddefunc(t, sir, SIRL)
    sl = SIRL(:, 1);
    il = SIRL(:, 2);
    rl = SIRL(:, 3);

    n = sir(1) + sir(2) + sir(3);

    % Parameters
    alpha = 0.3095;
    beta = 0.2;
    rho = 1174.17;
    epsilon = 0.0063;
    delta = 3.9139E-05;

    % Changeable
    % People recovered that return to the
    % Susceptible population
    mu = 0.02;

    sirp = [
        rho - alpha*sir(1)*(sir(2)./n) - delta*sir(1) - mu*sl(1),
        alpha*sir(1)*(sir(2)./n) - (beta + delta + epsilon)*sir(2),
        beta*sir(2) - delta*sir(3) + mu*sl(1)
    ];
end

% sir_plot = dde23(@ddefunc, lags, sir0, [0, 10]);
options = odeset('NormControl', 'on', 'MaxStep', 1);
sir_plot = dde23(@ddefunc, [0,180], sir0, [lags], sir0, options);


figure;
plot(sir_plot.x, sir_plot.y);
grid on;
legend("Suspectible", "Infected", "Recovered");
