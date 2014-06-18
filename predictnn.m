function p = predictnn(X)
% load thetann1200rev65.mat;
load net300.mat;

% Useful values
m = size(X, 1);

p = zeros(size(X, 1), 1);

h1 = sigmoid([ones(m, 1) X] * Theta1');
h2 = sigmoid([ones(m, 1) h1] * Theta2');
[dummy, p] = max(h2, [], 2);
end

% sigmoid function
function g = sigmoid(z)
g = 1.0 ./ (1.0 + exp(-z));
end

