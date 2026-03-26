%% MA342 Project 2
clear variables;
close all;
clc

% Load the symbolic package
pkg load symbolic

% 1. Define numeric variables (e.g., coefficients)
num_a = 2;
num_b = 5;
num_c = 3;

% 2. Declare the unknown variable as symbolic
syms x

% 3. Form the symbolic equation using both symbolic and numeric variables
% Note the use of "==" for symbolic equations
% The equation is: 2*x + 5 == 3
equation = num_a * x + num_b == num_c;

% 4. Solve the equation for the unknown 'x'
% The result 'sol' is a symbolic type
sol = solve(equation, x);

% 5. Convert the symbolic solution to a numeric value (double)
numeric_solution = double(sol);

% Display the results
disp("Symbolic equation:");
disp(equation);
disp("Symbolic solution (sol):");
disp(sol);
disp("Numeric solution (numeric_solution):");
disp(numeric_solution);
