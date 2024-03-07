%   Animazione della manovra standard di cambio orbita
%
%   by Midfield Rockets

close all
clear all
clc

run('Plot_ManPCS.m')                        % Plot statico manovra

% Vettore Theta Orbita_tot percorsa
theta_vect_tot = [theta_vect_i;theta_vect_man1;theta_vect_mancirc;theta_vect_man2;theta_vect_man3;theta_vect_f];

% Vettore numero di frame
theta_vect_frame = zeros(length(theta_vect_tot),1);

% Condizioni di cambio orbita
change_ploti = length(theta_vect_i);
change_plot1 = length(theta_vect_man1) + length(theta_vect_i);
change_plotc = change_plot1 + length(theta_vect_mancirc);
change_plot2 = change_plotc + length(theta_vect_man2);
change_plot3 = change_plot2 + length(theta_vect_man3);
change_plotf = change_plot3 + length(theta_vect_f);

% Vettori plot Orbita_totale
X_Orbita_tot = [X_Orbita_i,X_Orbita_1,X_Orbita_circ,X_Orbita_2,X_Orbita_3,X_Orbita_f];
Y_Orbita_tot = [Y_Orbita_i,Y_Orbita_1,Y_Orbita_circ,Y_Orbita_2,Y_Orbita_3,Y_Orbita_f];
Z_Orbita_tot = [Z_Orbita_i,Z_Orbita_1,Z_Orbita_circ,Z_Orbita_2,Z_Orbita_3,Z_Orbita_f];



%% PLOT PARTE STATICA

fig = figure (2);
% Definizione assi plot
view(3)
grid on
axis equal
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title('3D animation Manovra PCS')
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
plot3(X_Orbita_i_cmpl,Y_Orbita_i_cmpl,Z_Orbita_i_cmpl,'LineWidth',1.0,'LineStyle',':','Color','r')      % Orbita_i completa
plot3(X_Orbita_i(1),Y_Orbita_i(1),Z_Orbita_i(1),'o','MarkerEdgeColor','r','MarkerFaceColor','#ffa500')          % Punto iniziale
plot3(X_Orbita_1_cmpl,Y_Orbita_1_cmpl,Z_Orbita_1_cmpl,'LineWidth',1.0,'LineStyle',':','Color','g')      % Orbita_1 completa
plot3(X_Orbita_1(1),Y_Orbita_1(1),Z_Orbita_1(1),'o','MarkerEdgeColor','g')                              % Punto inizio percorso Orbita_1
plot3(X_Orbita_2_cmpl,Y_Orbita_2_cmpl,Z_Orbita_2_cmpl,'LineWidth',1.0,'LineStyle',':','Color','m')      % Orbita_2 completa
plot3(X_Orbita_2(1),Y_Orbita_2(1),Z_Orbita_2(1),'o','MarkerEdgeColor','m')                              % Punto inizio percorso Orbita_2
plot3(X_Orbita_circ_cmpl,Y_Orbita_circ_cmpl,Z_Orbita_circ_cmpl,'LineWidth',1.0,'LineStyle',':','Color','y')      % Orbita circolare completa
plot3(X_Orbita_circ(1),Y_Orbita_circ(1),Z_Orbita_circ(1),'o','MarkerEdgeColor','y')                     % Punto inizio percorso Orbita_circ
plot3(X_Orbita_3_cmpl,Y_Orbita_3_cmpl,Z_Orbita_3_cmpl,'LineWidth',1.0,'LineStyle',':','Color','c')      % Orbita_3 completa
plot3(X_Orbita_3(1),Y_Orbita_3(1),Z_Orbita_3(1),'o','MarkerEdgeColor','c')                              % Punto inizio percorso Orbita_3
plot3(X_Orbita_f_cmpl,Y_Orbita_f_cmpl,Z_Orbita_f_cmpl,'LineWidth',1.0,'LineStyle',':','Color','b')      % Orbita_4 completa
plot3(X_Orbita_f(1),Y_Orbita_f(1),Z_Orbita_f(1),'o','MarkerEdgeColor','b')                              % Punto inizio percorso Orbita_f
plot3(X_Orbita_f(end),Y_Orbita_f(end),Z_Orbita_f(end),'o','MarkerEdgeColor','k','MarkerFaceColor','#5f5f5f')    % Punto finale


%% PLOT PARTE DINAMICA

% Plot single frame
for k_frame = 1:length(theta_vect_frame)    
    
    if (k_frame < change_ploti)    
        % Plot orbita_i
        plot3(X_Orbita_tot(1,1:k_frame),Y_Orbita_tot(1,1:k_frame),Z_Orbita_tot(1,1:k_frame),'Color','r','LineWidth',2.0)
            
        % Plot vettore velocità satellite su orbita_i
        [~,V_orb_i] = ParOrb2RV(a_i,e_i,i_i,OM_i,om_i, theta_vect_tot(k_frame), mu_Earth);
        V_vector = quiver3(X_Orbita_tot(k_frame),Y_Orbita_tot(k_frame),Z_Orbita_tot(k_frame),V_orb_i(1),V_orb_i(2),V_orb_i(3),1000,'Color','k','LineWidth',2.0);

    elseif (k_frame > change_ploti) && (k_frame < change_plot1)
        % Plot orbita_1
        plot3(X_Orbita_tot(1,change_ploti:k_frame),Y_Orbita_tot(1,change_ploti:k_frame),Z_Orbita_tot(1,change_ploti:k_frame),'Color','g','LineWidth',2.0)
        
        % Plot vettore velocità satellite su orbita_1
        [~,V_orb_i] = ParOrb2RV(a_i,e_i,i_f,OM_f,om_2, theta_vect_tot(k_frame), mu_Earth);
        V_vector = quiver3(X_Orbita_tot(k_frame),Y_Orbita_tot(k_frame),Z_Orbita_tot(k_frame),V_orb_i(1),V_orb_i(2),V_orb_i(3),1000,'Color','k','LineWidth',2.0);
        
    elseif (k_frame > change_plot1) && (k_frame < change_plotc)
        % Plot orbita_c
        plot3(X_Orbita_tot(1,change_plot1:k_frame),Y_Orbita_tot(1,change_plot1:k_frame),Z_Orbita_tot(1,change_plot1:k_frame),'Color','y','LineWidth',2.0)
        
        % Plot vettore velocità satellite su orbita_c
        [~,V_orb_i] = ParOrb2RV(r_anChange,0,i_f,OM_f,om_2, theta_vect_tot(k_frame), mu_Earth);
        V_vector = quiver3(X_Orbita_tot(k_frame),Y_Orbita_tot(k_frame),Z_Orbita_tot(k_frame),V_orb_i(1),V_orb_i(2),V_orb_i(3),1000,'Color','k','LineWidth',2.0); 
    
    elseif (k_frame > change_plotc) && (k_frame < change_plot2)
        % Plot orbita_2
        plot3(X_Orbita_tot(1,change_plotc:k_frame),Y_Orbita_tot(1,change_plotc:k_frame),Z_Orbita_tot(1,change_plotc:k_frame),'Color','m','LineWidth',2.0)
        
        % Plot vettore velocità satellite su orbita_2
        [~,V_orb_i] = ParOrb2RV(a_i,e_i,i_f,OM_f,om_3, theta_vect_tot(k_frame), mu_Earth);
        V_vector = quiver3(X_Orbita_tot(k_frame),Y_Orbita_tot(k_frame),Z_Orbita_tot(k_frame),V_orb_i(1),V_orb_i(2),V_orb_i(3),1000,'Color','k','LineWidth',2.0);
        
    elseif (k_frame > change_plot2) && (k_frame < change_plot3)
        % Plot orbita_3
        plot3(X_Orbita_tot(1,change_plot2:k_frame),Y_Orbita_tot(1,change_plot2:k_frame),Z_Orbita_tot(1,change_plot2:k_frame),'Color','c','LineWidth',2.0)
        
        % Plot vettore velocità satellite su orbita_3
        [~,V_orb_i] = ParOrb2RV(a_t,e_t,i_f,OM_f,om_t, theta_vect_tot(k_frame), mu_Earth);
        V_vector = quiver3(X_Orbita_tot(k_frame),Y_Orbita_tot(k_frame),Z_Orbita_tot(k_frame),V_orb_i(1),V_orb_i(2),V_orb_i(3),1000,'Color','k','LineWidth',2.0);
        
    elseif (k_frame > change_plot3) && (k_frame < change_plotf)
        % Plot orbita_f
        plot3(X_Orbita_tot(1,change_plot3:k_frame),Y_Orbita_tot(1,change_plot3:k_frame),Z_Orbita_tot(1,change_plot3:k_frame),'Color','b','LineWidth',2.0)
        
        % Plot vettore velocità satellite su orbita_f
        [~,V_orb_i] = ParOrb2RV(a_f,e_f,i_f,OM_f,om_f, theta_vect_tot(k_frame), mu_Earth);
        V_vector = quiver3(X_Orbita_tot(k_frame),Y_Orbita_tot(k_frame),Z_Orbita_tot(k_frame),V_orb_i(1),V_orb_i(2),V_orb_i(3),1000,'Color','k','LineWidth',2.0);
        
    end
    
    % Plot satellite
    R_Sat = 500;
    Center_s = [X_Orbita_tot(k_frame);Y_Orbita_tot(k_frame);Z_Orbita_tot(k_frame)];
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
filename = 'Animated_ManPCS.gif';       % Fix the local Path: '...\MediaOpt\Animated_orb_i.gif'
for k_frame = 1:length(theta_vect_frame)
    [A,map] = rgb2ind(im{k_frame},256);
    if k_frame == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.01);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.01);
    end
end
