%   Plot della manovra standard di cambio orbita
%
%   by Midfield Rockets

close all
clear all
clc

run('ManovraSPA.m')                         % Calcolo dati manovra
offset_Plot = 0.005;                         % Offset per il plot
theta_vect_cmpl = (0:offset_Plot:2*pi)';    % Vettore orbita completa

% Calcoli preliminari parametri utili
p_i = a_i * (1 - e_i.^2);
p_f = a_f * (1 - e_f.^2);
r_pi = p_i / (1 + e_i);
r_pf = p_f / (1 + e_f);
r_ai = p_i / (1 - e_i);
r_af = p_f / (1 - e_f);

%% CALCOLI from ORBITA 1 to MANOVRA 1

% Vettore Theta Manovra_1
if (Start_Bitan == 1)
    if theta_i < pi
        theta_vect_i = (theta_i:offset_Plot:pi)';
    elseif theta_i > pi
        theta_vect_i = (theta_i:offset_Plot:(2*pi+pi))';
    elseif (theta_i == pi)
        theta_vect_i = 0;
    end
elseif (Start_Bitan == 0)  
    if (theta_i == 0) || (theta_i == 2*pi)
        theta_vect_i = 0;
    else
        theta_vect_i = (theta_i:offset_Plot:2*pi)';
    end       
end

% Inizializzazione vettori posizione e velocità Orbita_i
R_i = zeros(3,length(theta_vect_i));
V_i = zeros(3,length(theta_vect_i));
R_i_cmpl = zeros(3,length(theta_vect_cmpl));

% Calcolo vettore posizione e velocità Orbita_i
for k_i = 1:length(theta_vect_i)
    [rr,vv] = ParOrb2RV(a_i,e_i,i_i,OM_i,om_i,theta_vect_i(k_i), mu_Earth);
    R_i(:,k_i)=rr;
    V_i(:,k_i)=vv;
end
    
% Vettori plot Orbita_i
X_Orbita_i = R_i(1,:);
Y_Orbita_i = R_i(2,:);
Z_Orbita_i = R_i(3,:);

% Calcolo vettore posizione Orbita_i completa
for k_i = 1:length(theta_vect_cmpl)
    [rr,~] = ParOrb2RV(a_i,e_i,i_i,OM_i,om_i,theta_vect_cmpl(k_i), mu_Earth);
    R_i_cmpl(:,k_i)=rr;
end

% Vettori plot Orbita_i completa
X_Orbita_i_cmpl = R_i_cmpl(1,:);
Y_Orbita_i_cmpl = R_i_cmpl(2,:);
Z_Orbita_i_cmpl = R_i_cmpl(3,:);

%% CALCOLI ORBITA TRASFERIMENTO

% Vettore Theta Orbita_trasferimento
if (Start_Bitan == 0) && (Start_AnPeri == 0)            % peri-apo
    theta_vect_man1 = (0:offset_Plot:pi)';
    theta_2 = pi;
    
elseif (Start_Bitan == 1) && (Start_AnPeri == 0)        % apo-peri
    theta_vect_man1 = (pi:offset_Plot:2*pi)';
    theta_2 = 0;
elseif (Start_AnPeri ~= 0)
    error('Start_AnPeri non valido')
    
end


% Inizializzazione vettori posizione e velocità Orbita_1
R_1 = zeros(3,length(theta_vect_man1));
V_1 = zeros(3,length(theta_vect_man1));
R_1_cmpl = zeros(3,length(theta_vect_cmpl));

% Calcolo vettore posizione e velocità Orbita_1
for k_1 = 1:length(theta_vect_man1)
    [rr,vv] = ParOrb2RV(a_t,e_t,i_i,OM_i,om_i,theta_vect_man1(k_1), mu_Earth);
    R_1(:,k_1)=rr;
    V_1(:,k_1)=vv;
end
    
% Vettori plot Orbita_1
X_Orbita_1 = R_1(1,:);
Y_Orbita_1 = R_1(2,:);
Z_Orbita_1 = R_1(3,:);

% Calcolo vettore posizione Orbita_1 completa
for k_1 = 1:length(theta_vect_cmpl)
    [rr,~] = ParOrb2RV(a_t,e_t,i_i,OM_i,om_i,theta_vect_cmpl(k_1), mu_Earth);
    R_1_cmpl(:,k_1)=rr;
end

% Vettori plot Orbita_1 completa
X_Orbita_1_cmpl = R_1_cmpl(1,:);
Y_Orbita_1_cmpl = R_1_cmpl(2,:);
Z_Orbita_1_cmpl = R_1_cmpl(3,:);


%% CALCOLI from MANOVRA 1 to MANOVRA 2
% Vettore Theta Orbita_2 percorsa
if (theta_2 < theta_3)
    theta_vect_man2 = (theta_2:offset_Plot:theta_3)';
elseif (theta_2 > theta_3)
    theta_vect_man2 = (theta_2:offset_Plot:(2*pi + theta_3))';
elseif (theta_2 == theta_3)
    theta_vect_man2 = 0;
end

% Inizializzazione vettori posizione e velocità Orbita_2
R_2 = zeros(3,length(theta_vect_man2));
V_2 = zeros(3,length(theta_vect_man2));
R_2_cmpl = zeros(3,length(theta_vect_cmpl));

% Calcolo vettore posizione e velocità Orbita_2
for k_2 = 1:length(theta_vect_man2)
    [rr,vv] = ParOrb2RV(a_f,e_f,i_i,OM_i,om_i,theta_vect_man2(k_2), mu_Earth);
    R_2(:,k_2)=rr;
    V_2(:,k_2)=vv;
end

% Vettori plot Orbita_2
X_Orbita_2 = R_2(1,:);
Y_Orbita_2 = R_2(2,:);
Z_Orbita_2 = R_2(3,:);

% Calcolo vettore posizione Orbita_2 completa
for k_2 = 1:length(theta_vect_cmpl)
    [rr,~] = ParOrb2RV(a_f,e_f,i_i,OM_i,om_i,theta_vect_cmpl(k_2), mu_Earth);
    R_2_cmpl(:,k_2)=rr;
end

% Vettori plot Orbita_i completa
X_Orbita_2_cmpl = R_2_cmpl(1,:);
Y_Orbita_2_cmpl = R_2_cmpl(2,:);
Z_Orbita_2_cmpl = R_2_cmpl(3,:);


%% CALCOLI from MANOVRA 2 to MANOVRA 3
% Vettore Theta Manovra_3
if theta_3 < theta_4
    theta_vect_man3 = (theta_3:offset_Plot:theta_4)';
elseif theta_3 > theta_4
    theta_vect_man3 = (theta_3:offset_Plot:(2*pi + theta_4))';
elseif (theta_3 == theta_4)
    theta_vect_man3 = 0;
end

% Inizializzazione vettori posizione e velocità Orbita_3
R_3 = zeros(3,length(theta_vect_man3));
V_3 = zeros(3,length(theta_vect_man3));
R_3_cmpl = zeros(3,length(theta_vect_cmpl));

% Calcolo vettore posizione e velocità Orbita_3
for k_3 = 1:length(theta_vect_man3)
    [rr,vv] = ParOrb2RV(a_f,e_f,i_f,OM_f,om_2,theta_vect_man3(k_3), mu_Earth);
    R_3(:,k_3)=rr;
    V_3(:,k_3)=vv;
end
    
% Vettori plot Manovra_3
X_Orbita_3 = R_3(1,:);
Y_Orbita_3 = R_3(2,:);
Z_Orbita_3 = R_3(3,:);

% Calcolo vettore posizione Orbita_3 completa
for k_3 = 1:length(theta_vect_cmpl)
    [rr,~] = ParOrb2RV(a_f,e_f,i_f,OM_f,om_2,theta_vect_cmpl(k_3), mu_Earth);
    R_3_cmpl(:,k_3)=rr;
end

% Vettori plot Orbita_3 completa
X_Orbita_3_cmpl = R_3_cmpl(1,:);
Y_Orbita_3_cmpl = R_3_cmpl(2,:);
Z_Orbita_3_cmpl = R_3_cmpl(3,:);



%% CALCOLI from ORIBITA 3 to Pt.FINALE
% Vettore Theta Orbita_f
if (theta_5 < theta_f)
    theta_vect_f = (theta_5:offset_Plot:theta_f)';
elseif (theta_5 > theta_f)
    theta_vect_f = (theta_5:offset_Plot:(2*pi + theta_f))';
elseif (theta_5 == theta_f)
    theta_vect_f = 0;
end

% Inizializzazione vettori posizione e velocità Orbita_f 
R_f = zeros(3,length(theta_vect_f));
V_f = zeros(3,length(theta_vect_f));
R_f_cmpl = zeros(3,length(theta_vect_cmpl));

% Calcolo vettore posizione e velocità Orbita_f
for k_f = 1:length(theta_vect_f)
    [rr,vv] = ParOrb2RV(a_f,e_f,i_f,OM_f,om_f,theta_vect_f(k_f), mu_Earth);
    R_f(:,k_f)=rr;
    V_f(:,k_f)=vv;
end
    
% Vettori plot Orbita_f
X_Orbita_f = R_f(1,:);
Y_Orbita_f = R_f(2,:);
Z_Orbita_f = R_f(3,:);

% Calcolo vettore posizione Orbita_f completa
for k_f = 1:length(theta_vect_cmpl)
    [rr,~] = ParOrb2RV(a_f,e_f,i_f,OM_f,om_f,theta_vect_cmpl(k_f), mu_Earth);
    R_f_cmpl(:,k_f)=rr;
end

% Vettori plot Orbita_f completa
X_Orbita_f_cmpl = R_f_cmpl(1,:);
Y_Orbita_f_cmpl = R_f_cmpl(2,:);
Z_Orbita_f_cmpl = R_f_cmpl(3,:);


%% PLOT
% Definizione assi plot
figure(1)
view(3)
grid on
axis equal
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title('3D Manovra SPA')
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
plot3(X_Orbita_i,Y_Orbita_i,Z_Orbita_i,'LineWidth',2.0,'Color','r')                                     % Orbtia percorsa
plot3(X_Orbita_i_cmpl,Y_Orbita_i_cmpl,Z_Orbita_i_cmpl,'LineWidth',1.0,'LineStyle',':','Color','r')      % Orbita completa
plot3(X_Orbita_i(1),Y_Orbita_i(1),Z_Orbita_i(1),'o','MarkerEdgeColor','r','MarkerFaceColor','#ffa500')  % Punto inizio percorso

% Plot Orbita_1 3D
plot3(X_Orbita_1,Y_Orbita_1,Z_Orbita_1,'LineWidth',2.0,'Color','c')                                     % Orbita percorsa
plot3(X_Orbita_1_cmpl,Y_Orbita_1_cmpl,Z_Orbita_1_cmpl,'LineWidth',1.0,'LineStyle',':','Color','c')      % Orbita completa
plot3(X_Orbita_1(1),Y_Orbita_1(1),Z_Orbita_1(1),'o','MarkerEdgeColor','c')                              % Punto inizio percorso

% Plot Orbita_2 3D
plot3(X_Orbita_2,Y_Orbita_2,Z_Orbita_2,'LineWidth',2.0,'Color','g')                                     % Orbita percorsa
plot3(X_Orbita_2_cmpl,Y_Orbita_2_cmpl,Z_Orbita_2_cmpl,'LineWidth',1.0,'LineStyle',':','Color','g')      % Orbita completa
plot3(X_Orbita_2(1),Y_Orbita_2(1),Z_Orbita_2(1),'o','MarkerEdgeColor','g')                              % Punto inizio percorso

% Plot Orbita_3 3D
plot3(X_Orbita_3,Y_Orbita_3,Z_Orbita_3,'LineWidth',2.0,'Color','m')                                     % Orbita percorsa
plot3(X_Orbita_3_cmpl,Y_Orbita_3_cmpl,Z_Orbita_3_cmpl,'LineWidth',1.0,'LineStyle',':','Color','m')      % Orbita completa
plot3(X_Orbita_3(1),Y_Orbita_3(1),Z_Orbita_3(1),'o','MarkerEdgeColor','m')                              % Punto inizio percorso

% Plot Orbita_f 3D
plot3(X_Orbita_f,Y_Orbita_f,Z_Orbita_f,'LineWidth',2.0,'Color','b')                                     % Orbita percorsa
plot3(X_Orbita_f_cmpl,Y_Orbita_f_cmpl,Z_Orbita_f_cmpl,'LineWidth',1.0,'LineStyle',':','Color','b')      % Orbita completa
plot3(X_Orbita_f(1),Y_Orbita_f(1),Z_Orbita_f(1),'o','MarkerEdgeColor','b')                              % Punto inizio percorso
plot3(X_Orbita_f(end),Y_Orbita_f(end),Z_Orbita_f(end),'o','MarkerEdgeColor','k','MarkerFaceColor','#5f5f5f')    % Punto finale

drawnow
hold off
