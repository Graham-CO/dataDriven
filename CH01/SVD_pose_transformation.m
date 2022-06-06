%% Singular Value Decomposition - Geometrical Interpretation
% Graham Williams | grwi2594@colorado.edu

% Using rotation matrices as U, scaling matrics as Sigma, and identity as V
% Create a geometrical interpretation of SVD

clear all, close all, clc

%% Create X 
% labeled R, as it is a scaling/rotating matrix
theta = [pi/15; -pi/9; -pi/20];         % rotation angles
Sigma = diag([3; 1; 0.5]);              % scale x, then y, then z

Rx = [1 0 0;                            % rotate about x-axis
    0 cos(theta(1)) -sin(theta(1));
    0 sin(theta(1)) cos(theta(1))];

Ry = [cos(theta(2)) 0 sin(theta(2));    % rotate about y-axis
    0 1 0;
    -sin(theta(2)) 0 cos(theta(2))];

Rz = [cos(theta(3)) -sin(theta(3)) 0;   % rotate about z-axis
    sin(theta(3)) cos(theta(3)) 0;
    0 0 1];

R = Rz*Ry*Rx*Sigma;                     % rotate and scale

% Confirm that U = rotation, S = stretch, V = identity
% [U,S,V] = svd(R); % comment 29/30 out to see original transform
% R = U*S;

%% Plot Sphere and Principal Axes
subplot(1,2,1), hold on

% sphere
[x,y,z] = sphere(25);
h1=surf(x,y,z); hold on

% axes
plot3([-2 2], [0 0], [0 0],'k','LineWidth',6); hold on
plot3([0 0], [-2 2], [0 0],'k','LineWidth',6); hold on
plot3([0 0], [0 0], [-2 2],'k','LineWidth',6);

% equitorial rings
theta = (0:.001:1)*2*pi;
ring1 = [cos(theta);    sin(theta);     0*theta];
ring2 = [0*theta;       cos(theta);     sin(theta)];
ring3 = [cos(theta);    0*theta;        sin(theta)];

plot3(ring1(1,:),ring1(2,:),ring1(3,:),'k','LineWidth',6);
plot3(ring2(1,:),ring2(2,:),ring2(3,:),'k','LineWidth',6);
plot3(ring3(1,:),ring3(2,:),ring3(3,:),'k','LineWidth',6);


% figure properties
set(h1,'EdgeColor','none','FaceColor',[.5 .5 .5],'FaceAlpha',1)
set(gca,'FontSize',13);
set(gcf,'PaperPositionMode','auto') % sets saved figure size to be same as
                                    % figure window 
colormap jet, lighting phong, shading interp, axis equal
axis([-2 2 -2 2 -2 2]), view([45 26]) 

%% Construct Ellipsoid
xR = 0*x;  yR = 0*y;  zR = 0*z; % create null matrices

for i=1:size(x,1) % for each row
    for j=1:size(x,2) % for each column in each row
        vec = [x(i,j); y(i,j); z(i,j)]; % gather the point coords
        vecR = R*vec; % scale and rotate the point
        xR(i,j) = vecR(1); % store the scaled/rotated point coords
        yR(i,j) = vecR(2);
        zR(i,j) = vecR(3);        
    end
end

%% Plot Ellipsoid
subplot(1,2,2), hold on

% ellipsoid
h2=surf(xR,yR,zR,z);  % using the z-position of sphere for color

% equitorial rings
ring1R = R*ring1;
ring2R = R*ring2;
ring3R = R*ring3;

plot3(ring1R(1,:),ring1R(2,:),ring1R(3,:),'k','LineWidth',6);
plot3(ring2R(1,:),ring2R(2,:),ring2R(3,:),'k','LineWidth',6);
plot3(ring3R(1,:),ring3R(2,:),ring3R(3,:),'k','LineWidth',6);

% axes
eX = [3; 0; 0];
eY = [0; 3; 0];
eZ = [0; 0; 3];
eXR = R*eX;
eYR = R*eY;
eZR = R*eZ;

plot3([-eXR(1) eXR(1)],[-eXR(2) eXR(2)], [-eXR(3) eXR(3)],'k','LineWidth',6);
plot3([-eYR(1) eYR(1)],[-eYR(2) eYR(2)], [-eYR(3) eYR(3)],'k','LineWidth',6);
plot3([-eZR(1) eZR(1)],[-eZR(2) eZR(2)], [-eZR(3) eZR(3)],'k','LineWidth',6);

% figure properties
set(h2,'FaceAlpha',1)
colormap jet, lighting phong, shading interp, axis equal
axis([-3 3 -3 3 -3 3]), view([45 26]) 
set(gcf,'Position',[100 100 800 350])

% save as 24-bit png
% print('-dpng','-r1800','SVD_as_rotation.png') % 1800 dots/inch