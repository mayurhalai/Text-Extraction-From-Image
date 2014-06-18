clear;clc;
load('data200.mat');
input_layer_size  = 1024;  % 32x32 Input Images of Digits
hidden_layer_size = 200;   % 200 hidden units
num_labels = 62;          % 62 labels,A-Z,a-z,0-9
traintimes = 100;        % (note that we have mapped "0" to label 10)

source = transpose(source);
target = transpose(target);
X = source;
m = size(X, 1);
changedata;
ex4;
% out = predict(Theta1,Theta2,tsource);
% fprintf('\nNeuralNetwork Accuracy: %f\n', mean(double(out == Y)) * 100);