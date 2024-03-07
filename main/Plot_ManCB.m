%   Plot della manovra CB
%
%   by Midfield Rockets

close all
clear all
clc

run('ManovraCB.m')                          % Calcolo dati manovra
offset_Plot = 0.05;                         % Offset per il plot
theta_vect_cmpl = (0:offset_Plot:2*pi)';    % Vettore orbita completa
N_vect_p = N_vect * 50000;

%% CIRCOLARIZZAZIONE ORBITA INIZIALE
% Calcolo vettore posizione Orbita_i completa
R_i_cmpl = zeros(3,length(theta_vect_cmpl));
for k_i = 1:length(theta_vect_cmpl)
    [rr,~] = ParOrb2RV(a_i,e_i,i_i,OM_i,om_i,theta_vect_cmpl(k_i), mu_Earth);
    R_i_cmpl(:,k_i)=rr;
end

% Vettori plot Orbita_2 completa
X_Orbita_i_cmpl = R_i_cmpl(1,:);
Y_Orbita_i_cmpl = R_i_cmpl(2,:);
Z_Orbita_i_cmpl = R_i_cmpl(3,:);

%% CALCOLI ORBITA CIRCOLARE - Manovra 1,2
% Vettore Theta Manovra_circ
theta_end_circ = theta_2;
[theta_end_circ] = RifasAngle(theta_end_circ);

% Vettore Theta Manovra_circ
if theta_1 < theta_end_circ
    theta_vect_mancirc = (theta_1:offset_Plot:theta_end_circ)';
elseif theta_1 > theta_end_circ
    theta_vect_mancirc = (theta_1:offset_Plot:(2*pi+theta_end_circ))';
elseif (theta_1 == theta_end_circ)
    theta_vect_mancirc = 0;
end


% Inizializzazione vettori posizione e velocità Orbita_2
R_circ = zeros(3,length(theta_vect_mancirc));
V_circ = zeros(3,length(theta_vect_mancirc));
R_circ_cmpl = zeros(3,length(theta_vect_cmpl));

% Calcolo vettore posizione e velocità Orbita_2
for k_circ = 1:length(theta_vect_mancirc)
    [rr,vv] = ParOrb2RV(r_circ,0,i_circ,OM_circ,0,theta_vect_mancirc(k_circ), mu_Earth);
    R_circ(:,k_circ)=rr;
    V_circ(:,k_circ)=vv;
end

% Vettori plot Orbita_2
X_Orbita_circ = R_circ(1,:);
Y_Orbita_circ = R_circ(2,:);
Z_Orbita_circ = R_circ(3,:);

% Calcolo vettore posizione Orbita_2 completa
for k_circ = 1:length(theta_vect_cmpl)
    [rr,~] = ParOrb2RV(r_circ,0,i_circ,OM_circ,0,theta_vect_cmpl(k_circ), mu_Earth);
    R_circ_cmpl(:,k_circ)=rr;
end

% Vettori plot Orbita_2 completa
X_Orbita_circ_cmpl = R_circ_cmpl(1,:);
Y_Orbita_circ_cmpl = R_circ_cmpl(2,:);
Z_Orbita_circ_cmpl = R_circ_cmpl(3,:);



%% CALCOLI ORBITA BIELLITTICA ANDATA - Manovra 3,4
% Vettore Theta Orbita_1
theta_vect_man1 = (0:offset_Plot:theta_3)';

% Inizializzazione vettori posizione e velocità Orbita_1
R_1 = zeros(3,length(theta_vect_man1));
V_1 = zeros(3,length(theta_vect_man1));
R_1_cmpl = zeros(3,length(theta_vect_cmpl));

% Calcolo vettore posizione e velocità Orbita_1
for k_1 = 1:length(theta_vect_man1)
    [rr,vv] = ParOrb2RV(a_b,e_b,i_circ,OM_circ,om_b,theta_vect_man1(k_1), mu_Earth);
    R_1(:,k_1)=rr;
    V_1(:,k_1)=vv;
end

% Vettori plot Manovra_1
X_Orbita_1 = R_1(1,:);
Y_Orbita_1 = R_1(2,:);
Z_Orbita_1 = R_1(3,:);

% Calcolo vettore posizione Orbita_1 completa
for k_1 = 1:length(theta_vect_cmpl)
    [rr,~] = ParOrb2RV(a_b,e_b,i_circ,OM_circ,om_b,theta_vect_cmpl(k_1), mu_Earth);
    R_1_cmpl(:,k_1)=rr;
end

% Vettori plot Orbita_1 completa
X_Orbita_1_cmpl = R_1_cmpl(1,:);
Y_Orbita_1_cmpl = R_1_cmpl(2,:);
Z_Orbita_1_cmpl = R_1_cmpl(3,:);


%% CALCOLI ORBITA BIELLITTICA RITORNO - Manovra 4,5
% Vettore Theta Manovra_2
theta_vect_man2 = (theta_3:offset_Plot:(2*pi))';

%         [theta_4] = RifasAngle(theta_4);
%         if theta_3 < theta_4
%             theta_vect_man2 = (theta_3:offset_Plot:theta_4)';
%         elseif theta_3 > theta_4
%             theta_vect_man2 = (theta_3:offset_Plot:(2*pi + theta_4))';
%         elseif (theta_3 == theta_4)
%             theta_vect_man2 = 0;
%         end

% Inizializzazione vettori posizione e velocità Orbita_2
R_2 = zeros(3,length(theta_vect_man2));
V_2 = zeros(3,length(theta_vect_man2));
R_2_cmpl = zeros(3,length(theta_vect_cmpl));

% Calcolo vettore posizione e velocità Orbita_2
for k_2 = 1:length(theta_vect_man2)
    [rr,vv] = ParOrb2RV(a_b2,e_b2,i_f,OM_f,om_2,theta_vect_man2(k_2),mu_Earth);
    R_2(:,k_2)=rr;
    V_2(:,k_2)=vv;
end

% Vettori plot Orbita_2
X_Orbita_2 = R_2(1,:);
Y_Orbita_2 = R_2(2,:);
Z_Orbita_2 = R_2(3,:);

% Calcolo vettore posizione Orbita_2 completa
for k_2 = 1:length(theta_vect_cmpl)
    [rr,~] = ParOrb2RV(a_b2,e_b2,i_f,OM_f,om_2,theta_vect_cmpl(k_2),mu_Earth);
    R_2_cmpl(:,k_2)=rr;
end

% Vettori plot Orbita_2 completa
X_Orbita_2_cmpl = R_2_cmpl(1,:);
Y_Orbita_2_cmpl = R_2_cmpl(2,:);
Z_Orbita_2_cmpl = R_2_cmpl(3,:);


%% CALCOLI ORBITA FINALE CAMBIO PERICENTRO - Manovra 5,6
% Vettore Theta Manovra_3
[theta_6] = RifasAngle(theta_6);
if theta_5 < theta_6
    theta_vect_man3 = (theta_5:offset_Plot:theta_6)';
elseif theta_5 > theta_6
    theta_vect_man3 = (theta_5:offset_Plot:(2*pi + theta_6))';
elseif (theta_5 == theta_6)
    theta_vect_man3 = 0;
end

% Inizializzazione vettori posizione e velocità Orbita_3
R_3 = zeros(3,length(theta_vect_man3));
V_3 = zeros(3,length(theta_vect_man3));
R_3_cmpl = zeros(3,length(theta_vect_cmpl));

% Calcolo vettore posizione e velocità Orbita_3
for k_3 = 1:length(theta_vect_man3)
    [rr,vv] = ParOrb2RV(a_f,e_f,i_f,OM_f,om_3,theta_vect_man3(k_3), mu_Earth);
    R_3(:,k_3)=rr;
    V_3(:,k_3)=vv;
end

% Vettori plot Orbita_3
X_Orbita_3 = R_3(1,:);
Y_Orbita_3 = R_3(2,:);
Z_Orbita_3 = R_3(3,:);

% Calcolo vettore posizione Orbita_3 completa
for k_3 = 1:length(theta_vect_cmpl)
    [rr,~] = ParOrb2RV(a_f,e_f,i_f,OM_f,om_3,theta_vect_cmpl(k_3), mu_Earth);
    R_3_cmpl(:,k_3)=rr;
end

% Vettori plot Orbita_3 completa
X_Orbita_3_cmpl = R_3_cmpl(1,:);
Y_Orbita_3_cmpl = R_3_cmpl(2,:);
Z_Orbita_3_cmpl = R_3_cmpl(3,:);


%% CALCOLI from CAMBIO PERICENRO to Pt.FINALE
% Vettore Theta Orbita_f
if (theta_7 < theta_f)
    theta_vect_f = (theta_7:offset_Plot:theta_f)';
elseif (theta_7 > theta_f)
    theta_vect_f = (theta_7:offset_Plot:(2*pi + theta_f))';
elseif (theta_7 == theta_f)
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
figure(1)
view(3)
grid on
axis equal
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title('3D Manovra CB')
view( [1 1 1] )

%Plot Terra 3D
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
plot3(R_i(1),R_i(2),R_i(3),'o','MarkerEdgeColor','k','MarkerFaceColor','k')  % Punto inizio percorso
plot3(X_Orbita_i_cmpl,Y_Orbita_i_cmpl,Z_Orbita_i_cmpl,'LineWidth',1.0,'LineStyle',':','Color','k')      % Orbita completa

% Plot Orbita_circ 3D
plot3(X_Orbita_circ,Y_Orbita_circ,Z_Orbita_circ,'LineWidth',2.0,'Color','r')                                     % Orbtia percorsa
plot3(X_Orbita_circ_cmpl,Y_Orbita_circ_cmpl,Z_Orbita_circ_cmpl,'LineWidth',1.0,'LineStyle',':','Color','r')      % Orbita completa
plot3(X_Orbita_circ(1),Y_Orbita_circ(1),Z_Orbita_circ(1),'o','MarkerEdgeColor','r','MarkerFaceColor','#ffa500')  % Punto inizio percorso

% Plot Orbita_1 3D
plot3(X_Orbita_1,Y_Orbita_1,Z_Orbita_1,'LineWidth',2.0,'Color','g')                                     % Orbita percorsa
plot3(X_Orbita_1_cmpl,Y_Orbita_1_cmpl,Z_Orbita_1_cmpl,'LineWidth',1.0,'LineStyle',':','Color','g')      % Orbita completa
plot3(X_Orbita_1(1),Y_Orbita_1(1),Z_Orbita_1(1),'o','MarkerEdgeColor','g')                              % Punto inizio percorso

% Plot Orbita_2 3D
plot3(X_Orbita_2,Y_Orbita_2,Z_Orbita_2,'LineWidth',2.0,'Color','m')                                     % Orbita percorsa
plot3(X_Orbita_2_cmpl,Y_Orbita_2_cmpl,Z_Orbita_2_cmpl,'LineWidth',1.0,'LineStyle',':','Color','m')      % Orbita completa
plot3(X_Orbita_2(1),Y_Orbita_2(1),Z_Orbita_2(1),'o','MarkerEdgeColor','m')                              % Punto inizio percorso

% Plot Orbita_3 3D
plot3(X_Orbita_3,Y_Orbita_3,Z_Orbita_3,'LineWidth',2.0,'Color','c')                                     % Orbita percorsa
plot3(X_Orbita_3_cmpl,Y_Orbita_3_cmpl,Z_Orbita_3_cmpl,'LineWidth',1.0,'LineStyle',':','Color','c')      % Orbita completa
plot3(X_Orbita_3(1),Y_Orbita_3(1),Z_Orbita_3(1),'o','MarkerEdgeColor','c')                              % Punto inizio percorso

% Plot Orbita_f 3D
plot3(X_Orbita_f,Y_Orbita_f,Z_Orbita_f,'LineWidth',2.0,'Color','b')                                     % Orbita percorsa
plot3(X_Orbita_f_cmpl,Y_Orbita_f_cmpl,Z_Orbita_f_cmpl,'LineWidth',1.0,'LineStyle',':','Color','b')      % Orbita completa
plot3(X_Orbita_f(1),Y_Orbita_f(1),Z_Orbita_f(1),'o','MarkerEdgeColor','b')                              % Punto inizio percorso
plot3(X_Orbita_f(end),Y_Orbita_f(end),Z_Orbita_f(end),'o','MarkerEdgeColor','k','MarkerFaceColor','#5f5f5f')    % Punto finale

%         % Linee costruzione
%         plot3([0,R_a(1)],[0,R_a(2)],[0,R_a(3)],'Color','y') %direzione apocentro biellittica
%         plot3([0,-R_a(1)],[0,-R_a(2)],[0,-R_a(3)]) %direzione pricentro biellittica
%         plot3([0,N_vect_p(1)],[0,N_vect_p(2)],[0,N_vect_p(3)]) %direzione asse nodi
%         pt_Man_circ = R_int_norm .* r_circ;

drawnow
hold off
