%% Singular Value Decomposition - Multilinear Regression
% Graham Williams | grwi2594@colorado.edu

% Find relationship between 13 factors on Boston housing prices

clear all, close all, clc

load housing.data

b = housing(:,14);      % housing values in $1000s
A = housing(:,1:13);    % other factors,
A = [A ones(size(A,1),1)];  % Pad with ones for nonzero offset - why?

x = regress(b,A); 

% plot unsorted data regression
subplot(1,2,1)
plot(b,'k-','LineWidth',2);
title('Unsorted Data')
ylabel('Median Home Value [$1k]')
xlabel('Neighborhood')
hold on, grid on
plot(A*x,'-r.','MarkerSize',8);
xlabel('Neighborhood')

set(gca,'FontSize',13)
xlim([0 size(A,1)])

% plot sorted data 
subplot(1,2,2)
[b sortind] = sort(housing(:,14)); % sorted values

plot(b,'k-','LineWidth',2)
hold on, grid on

% plot regression on top 
plot(A(sortind,:)*x,'-r.','MarkerSize',8) 

% plot formatting
l1=legend('Housing value','Regression'); % legend
set(l1,'Location','NorthWest')
xlabel('Neighborhood')
title('Sorted Data')

set(gca,'FontSize',13)
xlim([0 size(A,1)])
set(gcf,'Position',[100 100 600 250])


%% Factor Correlation - Contribution to Regression
A2 = A-ones(size(A,1),1)*mean(A,1); % subtract the mean from each column - why?
for i=1:size(A,2)-1
    A2std = std(A2(:,i));
    A2(:,i) = A2(:,i)/A2std; % normalize by column's std deviation
end
A2(:,end) = ones(size(A,1),1);

x = regress(b,A2)
figure
bar(x(1:13))

xlabel('Attribute'), ylabel('Correlation')
set(gca,'FontSize',13)
set(gcf,'Position',[100 100 600 250])