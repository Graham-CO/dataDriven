%% Singular Value Decomposition - Image Compression
% Graham Williams | grwi2594@colorado.edu

% Using image compression to explore truncation in SVD
% Save a compressed image at various values of r,
% where r is the number of singular values kept in the truncated SVD rep.

clear all, close all, clc

A=imread('dog.jpg');
X=double(rgb2gray(A)); % Convert RBG->gray, 256 bit->double.
nx = size(X,1); ny = size(X,2);

figure, subplot(2,2,1)
imagesc(X), axis off, colormap gray
title('Original')

%% SVD Approximations
[U,S,V] = svd(X,'econ');

plotind = 2;
for r=[1 2 3]  % Truncation value
    Xapprox = U(:,1:r)*S(1:r,1:r)*V(:,1:r)'; % Approx. image
    subplot(2,2,plotind), plotind = plotind + 1;
    imagesc(Xapprox), axis off, colormap(gray);
    title(['r=',num2str(r,'%d'),', ',num2str(100*r*(nx+ny)/(nx*ny),'%2.2f'),'% storage']); 
end

%% Singular Values
figure
subplot(1,2,1), semilogy(diag(S),'k','LineWidth',2), grid on
xlabel('r') 
ylabel('Singular Value, \sigma_r')
xlim([-50 1550])
set(gca,'FontSize',14)

subplot(1,2,2), plot(cumsum(diag(S))/sum(diag(S)),'k','LineWidth',2), grid on
xlabel('r')
ylabel('Cumulative Energy')
xlim([-50 1550]); ylim([0 1.1])
set(gca,'FontSize', 14)

%% Correlation Matrices
tic
XXt = X*X';
toc

tic
XtX = X'*X;
toc

figure
subplot(1,2,1)
imagesc(XtX);
axis off, colormap(gray);

subplot(1,2,2)
imagesc(XXt);
axis off, colormap gray