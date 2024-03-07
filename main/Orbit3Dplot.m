close all;
clear all;
clc

%% DATI
% Costanti terra
mu_Earth = 398600;
R_Earth = 6378.14;
R_Plan = 1378.14;

% Input Orbita1
a_i = 36086.9;
e_i = 0.4939;
i_i = 1.3287;
om_i = 1.77220732;
OM_i = 0.996491496620195;
theta_start_i = 4.944924491685869;
theta_vect_i = (theta_start_i:0.05:(2*pi+theta_start_i))';           % campo di valori dell'anomalia vera

% Input Orbita2
a_f = 15000;
e_f = 0.1;
i_f = 0.2617993877991;
om_f = 0.5235987755983;
OM_f = 0.7853981633974;
theta_start_f = pi;
theta_vect_f = (theta_start_f:0.05:(2*pi+theta_start_f))';

%% CALCOLI ORBITA 1
% Parametri utili 
p_Orb_i = a_i .* (1 - e_i.^2);
R_i = zeros(3,length(theta_vect_i));
V_i = zeros(3,length(theta_vect_i));

for k_i = 1:length(theta_vect_i)
    [rr,vv] = ParOrb2RV(a_i,e_i,i_i,OM_i,om_i, theta_vect_i(k_i), mu_Earth);
    R_i(:,k_i)=rr;
    V_i(:,k_i)=vv;
end
    
% Vettori plot Orbita1
X_Orbita_i = R_i(1,:);
Y_Orbita_i = R_i(2,:);
Z_Orbita_i = R_i(3,:);


%% CALCOLI ORBITA 2
% Parametri utili 
p_Orb_f = a_f .* (1 - e_f.^2);           % campo di valori dell'anomalia vera (da 0 a 360°)
R_f = zeros(3,length(theta_vect_f));
V_f = zeros(3,length(theta_vect_f));

for k_f = 1:length(theta_vect_f)
    [rr,vv] = ParOrb2RV(a_f,e_f,i_f,OM_f,om_f, theta_vect_f(k_f), mu_Earth);
    R_f(:,k_f)=rr;
    V_f(:,k_f)=vv;
end
    
% Vettori plot Orbita1
X_Orbita_f = R_f(1,:);
Y_Orbita_f = R_f(2,:);
Z_Orbita_f = R_f(3,:);


%% PLOT
% Definizione assi plot
figure(1)
view(3)
grid on
axis equal
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title('3D orbit')
view( [1 1 1] )

% Plot Terra 3D
TERRA = imread('planisphere.jpg','jpg');
    props.FaceColor='texture';
    props.EdgeColor='none';
    props.FaceLighting='phong';
    props.Cdata = TERRA;
Center = [0; 0; 0];
[XX, YY, ZZ] = ellipsoid(Center(1),Center(2),Center(3),R_Earth,R_Earth,R_Earth,30);
surface(-XX, -YY, -ZZ,props);
hold on

% Plot Orbita_i 3D
plot3(X_Orbita_i,Y_Orbita_i,Z_Orbita_i,'LineWidth',2.0)
hold on

% Plot Orbita_f 3D
plot3(X_Orbita_f,Y_Orbita_f,Z_Orbita_f,'LineWidth',2.0)
hold on

% Plot vettore velocità inizio orbita_i
R=[1e4;2e4;1e4];
V=[-2.5;-2.5;3];
quiver3(R(1),R(2),R(3),V(1),V(2),V(3),1000,'LineWidth',2.0);
hold on

%         %% PLOT ANIMATO - animated line
%         figure(2)
% 
%         %Set plot axis 
%         view(3)
%         axis equal
%         grid on
%         xlabel('X [km]')
%         ylabel('Y [km]')
%         zlabel('Z [km]')
%         title('3D orbit animation')
% 
%         %Plot Terra 3D
%         TERRA = imread('planisphere.jpg','jpg');
%             props.FaceColor='texture';
%             props.EdgeColor='none';
%             props.FaceLighting='phong';
%             props.Cdata = TERRA;
%         Center = [0; 0; 0];
%         [XX, YY, ZZ] = ellipsoid(Center(1),Center(2),Center(3),R_Earth,R_Earth,R_Earth,30);
%         surface(-XX, -YY, -ZZ,props);
%         hold on
% 
%         %Plot animato orbita iniziale 3D con animated line
%         Orb_Line_i = animatedline(X_Orbita_i(1),Y_Orbita_i(1),Z_Orbita_i(1),'Color','g','LineWidth',2);
%         for k_i = 1:length(theta_vect_i)
%             addpoints(Orb_Line_i,X_Orbita_i(k_i),Y_Orbita_i(k_i),Z_Orbita_i(k_i));
%             drawnow limitrate
%             hold on    
% 
%             frame = getframe(figure(2));
%             im{k_i} = frame2im(frame);
%         end
% 
%         filename = '\MediaOpt\AnimatedLine_orb_1.gif';       % Fix the local Path
%         for k_i = 1:length(theta_vect_i)
%             [A,map] = rgb2ind(im{k_i},256);
%             if k_i == 1
%                 imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.01);
%             else
%                 imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.01);
%             end
%         end

%% PLOT ANIMATO ORBITA INIZIALE

fig = figure (3);
plot3(X_Orbita_i(1,:),Y_Orbita_i(1,:),Z_Orbita_i(1,:),'Color','r','LineWidth',1.0,'LineStyle',':')

% Definizione assi plot
view(3)
grid on
axis equal
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title('3D orbit animation orbita iniziale')

% Plot Terra 3D
TERRA = imread('planisphere.jpg','jpg');
    props.FaceColor='texture';
    props.EdgeColor='none';
    props.FaceLighting='phong';
    props.Cdata = TERRA;
Center = [0; 0; 0];
[XX, YY, ZZ] = ellipsoid(Center(1),Center(2),Center(3),R_Earth,R_Earth,R_Earth,30);
surface(XX, YY, ZZ,props);
hold on

    % Angolo rotazione plot
    % ang_view = linspace (30,80,length(theta_vect_i));

% Plot parte dinamica
for k_i = 1:length(theta_vect_i)    
    % Plot satellite
    Center_p = [X_Orbita_i(k_i);Y_Orbita_i(k_i);Z_Orbita_i(k_i)];
    [XX_p, YY_p, ZZ_p] = ellipsoid(Center_p(1),Center_p(2),Center_p(3),R_Plan,R_Plan,R_Plan,30);
    satellite = surface(XX_p, YY_p, ZZ_p);
    
    % Plot vettore satellite
    [~,V_orb_i] = ParOrb2RV(a_i,e_i,i_i,OM_i,om_i, theta_vect_i(k_i), mu_Earth);
    V_vector = quiver3(X_Orbita_i(k_i),Y_Orbita_i(k_i),Z_Orbita_i(k_i),V_orb_i(1),V_orb_i(2),V_orb_i(3),1000,'Color','b','LineWidth',2.0);
    
    % Plot obita satellite
    plot3(X_Orbita_i(1,1:k_i),Y_Orbita_i(1,1:k_i),Z_Orbita_i(1,1:k_i),'Color','r','LineWidth',2.0)
    
        %    % Rotazione visuale
        %    view([ang_view(k_i),30])
    
    % Salvataggio frame
    drawnow
    frame = getframe(fig);
    im{k_i} = frame2im(frame);
    delete(satellite)
    delete(V_vector)
end

% Generazione giff output
filename = '...\MediaOpt\Animated_orb_i.gif';       % Fix the local Path
for k_i = 1:length(theta_vect_i)
    [A,map] = rgb2ind(im{k_i},256);
    if k_i == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.01);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.01);
    end
end

%% PLOT ANIMATO ORBITA FINALE

fig = figure (4);
plot3(X_Orbita_f(1,:),Y_Orbita_f(1,:),Z_Orbita_f(1,:),'Color','r','LineWidth',1.0,'LineStyle',':')

% Definizione assi plot
view(3)
grid on
axis equal
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title('3D orbit animation orbita finale')
rotate3d on

% Plot Terra 3D
TERRA = imread('planisphere.jpg','jpg');
    props.FaceColor='texture';
    props.EdgeColor='none';
    props.FaceLighting='phong';
    props.Cdata = TERRA;
Center = [0; 0; 0];
[XX, YY, ZZ] = ellipsoid(Center(1),Center(2),Center(3),R_Earth,R_Earth,R_Earth,30);
surface(XX, YY, ZZ,props);
hold on

%   % Angolo rotazione plot
%   ang_view = linspace (30,80,length(theta_vect_f));

% Plot parte dinamica
for k_f = 1:length(theta_vect_f)
    % Plot satellite
    Center_p = [X_Orbita_f(k_f);Y_Orbita_f(k_f);Z_Orbita_f(k_f)];
    [XX_p, YY_p, ZZ_p] = ellipsoid(Center_p(1),Center_p(2),Center_p(3),R_Plan,R_Plan,R_Plan,30);
    satellite = surface(XX_p, YY_p, ZZ_p);
    
    % Plot vettore satellite
    [~,V_orb_f] = ParOrb2RV(a_f,e_f,i_f,OM_f,om_f, theta_vect_f(k_f), mu_Earth);
    V_vector = quiver3(X_Orbita_f(k_f),Y_Orbita_f(k_f),Z_Orbita_f(k_f),V_orb_f(1),V_orb_f(2),V_orb_f(3),1000,'Color','b','LineWidth',2.0);
    
    % Plot obita satellite
    plot3(X_Orbita_f(1,1:k_f),Y_Orbita_f(1,1:k_f),Z_Orbita_f(1,1:k_f),'Color','r','LineWidth',2.0)
    
    %   % Rotazione visuale
    %   view([ang_view(k_f),30])
    
    % Salvataggio frame
    drawnow
    frame = getframe(fig);
    im{k_f} = frame2im(frame);
    delete(satellite)
    delete(V_vector)
end

% Generazione giff output
filename = '...\MediaOpt\Animated_orb_f.gif';       % Fix the local Path
for k_f = 1:length(theta_vect_i)
    [A,map] = rgb2ind(im{k_f},256);
    if k_f == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.001);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.001);
    end
end

%% try
