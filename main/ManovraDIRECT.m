%% dati per plot dell'orbita di trasferimento

clc; close all ; clear all

mu_Earth = 398600.433 ;
deg_rad = 0.0174533 ;  % 1 grado in radianti

% Parametri orbita iniziale
R_i = [-5183.4184 ; 6189.4459 ; 4334.1737];
V_i = [-5.3130; -4.3350; 0.2136];
[a_i,e_i,i_i,OM_i,om_i,theta_i] = RV2ParOrb(R_i,V_i,mu_Earth);

a_f = 12610.0 ;
e_f = 0.2656 ;
i_f = 1.0430 ;       % 57.75°
OM_f =  1.8790 ;      % 107.65°  
om_f = 2.4080 ;      % 137.96°
theta_f = 2.3880 ;   % 136.82°

% orbIniz = [a_i,e_i,i_i,OM_i,om_i,theta_i];
% orbFin = [a_f,e_f,i_f,OM_f,om_f,theta_f];


% mercedes godo non hanno vinto
% [orbTrasf, deltaV1, deltaV2, deltaT, thetaPlot1, thetaPlot2, eVect, deltaVvect, omegaOK,thetaT1] = trasfDir(orbIniz,orbFin) ;

% alphatauri 
[ theta1, theta2, a_T_vect, e_T_vect, i_T,OM_T, om_T_OK, theta1_vect, theta2_vect,deltaV_vect,om_T_NO,om_T_vect,om_T_contr,om_T_OP,Verso_OrbitaT] = TrasfDiretto_vect(mu_Earth, a_i, e_i, i_i, om_i, OM_i, theta_i, a_f, e_f, i_f, om_f, OM_f, theta_f);
% gasly
%[ theta1, theta2, a_T_vect, e_T_vect, i_T,OM_T, om_T_OK, theta1_vect, theta2_vect,deltaV_vect] = TrasfDiretto_gasly(mu, a_i, e_i, i_i, om_i, OM_i, theta_i, a_f, e_f, i_f, om_f, OM_f, theta_f)

vect_Plot = [om_T_OK',deltaV_vect'];
vect_sorted = sortrows(vect_Plot);

figure()
plot(vect_sorted(:,1),vect_sorted(:,2),'LineWidth',1.5,'Color','k')
xlabel('omegaOK')
ylabel('deltaV')

hold on
%% PLOT
if(Verso_OrbitaT==1)
    p1 = area([om_T_contr(21), om_T_contr(end)], [max(deltaV_vect), max(deltaV_vect)], 18, 'FaceColor', '#0072BD','LineStyle','none'); % e_T < 0
    area([om_T_contr(1), om_T_contr(20)], [max(deltaV_vect), max(deltaV_vect)], 18, 'FaceColor', '#0072BD','LineStyle','none') % e_T < 0
    
    p2 = area([om_T_OP(1)-deg_rad, om_T_OP(15)+deg_rad], [max(deltaV_vect), max(deltaV_vect)], 18, 'FaceColor', '#A2142F','LineStyle','none'); % e_T > 1
    area([om_T_OP(16)-deg_rad, om_T_OP(30)+deg_rad], [max(deltaV_vect), max(deltaV_vect)], 18, 'FaceColor', '#A2142F','LineStyle','none') % e_T > 1
    
    [min_deltaV,idx] = min(vect_sorted(:,2));
    p3 = plot(vect_sorted(idx,1),min_deltaV,'LineStyle','none','Marker','^','MarkerFaceColor','g','MarkerSize',8,'MarkerEdgeColor','k');
    
    legend ([p1,p2,p3],{'e_T<0','Open orbits','Best orbit'},'Location','best')
    
    hold off
    drawnow
    
elseif(Verso_OrbitaT==0)
    % gasly deve aggiustarlo
    p1 = area([om_T_contr(1), om_T_contr(end)], [min(deltaV_vect), min(deltaV_vect)], 18, 'FaceColor', '#0072BD','LineStyle','none'); % e_T < 0
    
    p2 = area([om_T_OP(1)-deg_rad, om_T_OP(15)+deg_rad], [min(deltaV_vect), min(deltaV_vect)], 18, 'FaceColor', '#A2142F','LineStyle','none'); % e_T > 1
    area([om_T_OP(16)-deg_rad, om_T_OP(30)+deg_rad], [min(deltaV_vect), min(deltaV_vect)], 18, 'FaceColor', '#A2142F','LineStyle','none') % e_T > 1
    
    [min_deltaV,idx] = min(vect_sorted(:,2));
    p3 = plot(vect_sorted(idx,1),min_deltaV,'LineStyle','none','Marker','^','MarkerFaceColor','g','MarkerSize',8,'MarkerEdgeColor','k');
    
    legend ([p1,p2,p3],{'e_T<0','Open orbits','Best orbit'},'Location','best')
    
    hold off
    drawnow
else
    error('retire the car')
end

[~,it_min]=min(deltaV_vect);
%it_min = 29 ; % si trova il minimo deltaV alla 29 iterazione

om_T_min = om_T_OK(it_min);
a_T_min = a_T_vect(it_min);
e_T_min = e_T_vect(it_min);
OM_T_min = OM_T ;
i_T_min = i_T ;
theta1_min = theta1_vect(it_min);
theta2_min = theta2_vect(it_min);


[dT_tot] = CalcoloTempi(a_T_min,e_T_min,theta1,theta2,mu_Earth);

%% Output video

[dV_tot] = min(deltaV_vect);

fprintf('\n Variabile verso orbita: %.0f ',Verso_OrbitaT)
fprintf('\n Costo totale della manovra: %.4f km/s',dV_tot)
fprintf('\n Tempo totale della manovra: %.4f s \n',dT_tot)




















