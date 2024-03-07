%   Animazione della manovra standard di cambio orbita
%
%   by Midfield Rockets

close all
clear all
clc

run('Plot_ManDIRECT.m')                        % Plot statico manovra

% Vettore Theta Orbita_tot percorsa
theta_vect_tot = (theta_vect_T);

% Vettore numero di frame
theta_vect_frame = zeros(length(theta_vect_tot),1);

%% PLOT PARTE STATICA

fig = figure (3);
% Definizione assi plot
view(3)
grid on
axis equal
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title('3D animation Manovra DIRECT')
view( [1 1 1] )

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

% Plot orbite e punti notevoli
plot3(X_Orbita_i_cmpl,Y_Orbita_i_cmpl,Z_Orbita_i_cmpl,'LineWidth',1.0,'LineStyle',':','Color','r')              % Orbita_i completa
plot3(X_Orbita_T(1),Y_Orbita_T(1),Z_Orbita_T(1),'o','MarkerEdgeColor','r','MarkerFaceColor','#ffa500')          % Punto iniziale
plot3(X_Orbita_T_cmpl,Y_Orbita_T_cmpl,Z_Orbita_T_cmpl,'LineWidth',1.0,'LineStyle',':','Color','g')              % Orbita_T completa
plot3(X_Orbita_f_cmpl,Y_Orbita_f_cmpl,Z_Orbita_f_cmpl,'LineWidth',1.0,'LineStyle',':','Color','b')              % Orbita_4 completa
plot3(X_Orbita_T(end),Y_Orbita_T(end),Z_Orbita_T(end),'o','MarkerEdgeColor','k','MarkerFaceColor','#5f5f5f')    % Punto finale


%% PLOT PARTE DINAMICA

% Plot single frame
for k_frame = 1:length(theta_vect_frame)    
       
        % Plot orbita_T
        plot3(X_Orbita_T(1,1:k_frame),Y_Orbita_T(1,1:k_frame),Z_Orbita_T(1,1:k_frame),'Color','g','LineWidth',2.0)
            
        % Plot vettore velocità satellite su orbita_i
        [~,V_orb_i] = ParOrb2RV(a_T_min,e_T_min,i_T_min,OM_T_min,om_T_min, theta_vect_tot(k_frame), mu_Earth);
        V_vector = quiver3(X_Orbita_T(k_frame),Y_Orbita_T(k_frame),Z_Orbita_T(k_frame),V_orb_i(1),V_orb_i(2),V_orb_i(3),1000,'Color','k','LineWidth',2.0);

    
    % Plot satellite
    R_Sat = 500;
    Center_s = [X_Orbita_T(k_frame);Y_Orbita_T(k_frame);Z_Orbita_T(k_frame)];
    [XX_s, YY_s, ZZ_s] = ellipsoid(Center_s(1),Center_s(2),Center_s(3),R_Sat,R_Sat,R_Sat,30);
    satellite = surface(XX_s, YY_s, ZZ_s);
    
    % Salvataggio frame
    drawnow
    frame = getframe(fig);
    im{k_frame} = frame2im(frame);
    if (k_frame < length(theta_vect_frame))
        delete(satellite)
    end
    delete(V_vector)
end

% Generazione giff output
filename = 'Animated_ManDIRECT.gif';       % Fix the local Path: '...\MediaOpt\Animated_orb_i.gif'
for k_frame = 1:length(theta_vect_frame)
    [A,map] = rgb2ind(im{k_frame},256);
    if k_frame == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.01);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.01);
    end
end
