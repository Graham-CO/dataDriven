%% Singular Value Decomposition - Multilinear Regression
% Graham Williams | grwi2594@colorado.edu

% Find relationship between proportion of ingredients in mixture to heat
% generation

clear all, close all, clc

load hald;  % Load Portland Cement dataset
A = ingredients;
b = heat;

[U,S,V] = svd(A,'econ');
x = V*inv(S)*U'*b;                    % Solve Ax=b using the SVD

plot(b,'k','LineWidth',2);  hold on            % Plot data
plot(A*x,'r-o','LineWidth',1.,'MarkerSize',2); % Plot regression
l1 = legend('Heat data','Regression','Location','northwest');
set(gca,'FontSize',16)
xlabel('Mixture Number')
ylabel('Heat [cal/g]')

%% Alternative 1  (regress)
x = regress(b,A)

%% Alternative 2  (pinv)
x = pinv(A)*b