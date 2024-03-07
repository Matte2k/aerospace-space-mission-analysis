%   Plot della manovra standard di cambio orbita
%
%   by Midfield Rockets

close all
clear all
clc

run('ManovraDIRECT.m')                         % Calcolo dati manovra

offset_Plot = 0.05;                         % Offset per il plot
theta_vect_cmpl = (0:offset_Plot:2*pi)';    % Vettore orbita completa
R_Earth = 6378.14;
theta_PeriG = 0;
theta_ApoG = pi;

%% ORBITA INIZIALE e FINALE

% Calcolo vettore posizione Orbita_i completa
for k_i = 1:length(theta_vect_cmpl)
    [rr,~] = ParOrb2RV(a_i,e_i,i_i,OM_i,om_i,theta_vect_cmpl(k_i), mu_Earth);
    R_i_cmpl(:,k_i)=rr;
end

% Vettori plot Orbita_i completa
X_Orbita_i_cmpl = R_i_cmpl(1,:);
Y_Orbita_i_cmpl = R_i_cmpl(2,:);
Z_Orbita_i_cmpl = R_i_cmpl(3,:);

% Calcolo vettore posizione Orbita_f completa
for k_f = 1:length(theta_vect_cmpl)
    [rr,~] = ParOrb2RV(a_f,e_f,i_f,OM_f,om_f,theta_vect_cmpl(k_f), mu_Earth);
    R_f_cmpl(:,k_f)=rr;
end

% Vettori plot Orbita_f completa
X_Orbita_f_cmpl = R_f_cmpl(1,:);
Y_Orbita_f_cmpl = R_f_cmpl(2,:);
Z_Orbita_f_cmpl = R_f_cmpl(3,:);


%% CALCOLI from ORBITA TRASF
% Vettore Theta Orbita_i percorsa
    if (theta1_min < theta2_min)
        theta_vect_T = (theta1_min:offset_Plot:theta2_min)';
    elseif (theta1_min > theta2_min)
        theta_vect_T = (theta1_min:offset_Plot:(2*pi + theta2_min))';
    elseif (theta1_min == theta2_min)
        theta_vect_T = 0;
    end

%   theta_vect_T = (theta2_min:offset_Plot:(2*pi + theta1_min))';

% Inizializzazione vettori posizione e velocità Orbita_i
R_T = zeros(3,length(theta_vect_T));
V_T = zeros(3,length(theta_vect_T));
R_T_cmpl = zeros(3,length(theta_vect_cmpl));

% Calcolo vettore posizione e velocità Orbita_i
for k_i = 1:length(theta_vect_T)
    [rr,vv] = ParOrb2RV(a_T_min,e_T_min,i_T_min,OM_T_min,om_T_min,theta_vect_T(k_i), mu_Earth);
    R_T(:,k_i)=rr;
    V_T(:,k_i)=vv;
end

% Vettori plot Orbita_i
X_Orbita_T = R_T(1,:);
Y_Orbita_T = R_T(2,:);
Z_Orbita_T = R_T(3,:);

% Calcolo vettore posizione Orbita_i completa
for k_i = 1:length(theta_vect_cmpl)
    [rr,~] = ParOrb2RV(a_T_min,e_T_min,i_T_min,OM_T_min,om_T_min,theta_vect_cmpl(k_i), mu_Earth);
    R_T_cmpl(:,k_i)=rr;
end

% Vettori plot Orbita_i completa
X_Orbita_T_cmpl = R_T_cmpl(1,:);
Y_Orbita_T_cmpl = R_T_cmpl(2,:);
Z_Orbita_T_cmpl = R_T_cmpl(3,:);



%% PLOT
% Definizione assi plot
figure(2)
view(3)
grid on
axis equal
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title('3D Manovra DIRECT')
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
plot3(X_Orbita_i_cmpl,Y_Orbita_i_cmpl,Z_Orbita_i_cmpl,'LineWidth',1.0,'LineStyle',':','Color','r')      % Orbita completa


% Plot Orbita_T 3D
plot3(X_Orbita_T,Y_Orbita_T,Z_Orbita_T,'LineWidth',2.0,'Color','g')                                     % Orbtia percorsa
plot3(X_Orbita_T_cmpl,Y_Orbita_T_cmpl,Z_Orbita_T_cmpl,'LineWidth',1.0,'LineStyle',':','Color','g')      % Orbita completa
plot3(X_Orbita_T(1),Y_Orbita_T(1),Z_Orbita_T(1),'o','MarkerEdgeColor','r','MarkerFaceColor','#ffa500')  % Punto inizio percorso

% Plot Orbita_f 3D
plot3(X_Orbita_f_cmpl,Y_Orbita_f_cmpl,Z_Orbita_f_cmpl,'LineWidth',1.0,'LineStyle',':','Color','b')      % Orbita completa
plot3(X_Orbita_T(end),Y_Orbita_T(end),Z_Orbita_T(end),'o','MarkerEdgeColor','k','MarkerFaceColor','#5f5f5f')    % Punto finale
 
drawnow
hold off
