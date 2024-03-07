% Manovra standard cambio orbita A32
% Elenco manovre eseguite:
%   1) cambio piano
%   2) cambio anomalia di pericentro circolarizzando
%   3) cambio forma

clear all
close all
clc

%% Scelta punti di manovra

% cambio piano
Pt_cambio_Piano = 1 ;     % [0 - 1]


% Cambio anomalia pericentro
Pt_Circ = 1 ;             % [0 - 1]
    
Start_AnPeri = 0 ;        % om_3 = om_f  -->  Start_AnPeri = 0 
                          % om_3 = om_f + pi  -->  Start_AnPeri = 1

% Cambio forma
Start_Bitan = 1 ;         %   om_i = om_f  -->  Start_Bitan = 0  -->  Perigeo-Apogeo
                          %   om_i = om_f  -->  Start_Bitan = 1  -->  Apogeo-Perigeo
                          %   om_i = om_f + pi  -->  Start_Bitan = 0  -->  Perigeo-Perigeo
                          %   om_i = om_f + pi  -->  Start_Bitan = 1  -->  Apogeo-Apogeo

% NOTA: funzionamento corretto NON garantito con 'Start_AnPeri = 1'

%% Input dati

% Costanti note
mu_Earth = 398600.433;
R_Earth = 6378.14;
theta_PeriG = 0;
theta_ApoG = pi;

% Parametri orbita iniziale
R_i = [-5183.4184 ; 6189.4459 ; 4334.1737];
V_i = [-5.3130; -4.3350; 0.2136];
[a_i,e_i,i_i,OM_i,om_i,theta_i] = RV2ParOrb(R_i,V_i,mu_Earth);
    % a_i = 9981.0950
    % e_i = 0.0860
    % i_i = 0.4931
    % om_i = 0.3332
    % OM_i = 0.7423
    % theta_i = 1.1977

% Parametri orbita finale
a_f = 12610.0;
e_f = 0.2656;
i_f = 1.0430;       % 57.75°
OM_f = 1.8790;      % 107.65°  
om_f = 2.4080;      % 137.96°
theta_f = 2.3880;   % 136.82°
[R_f,V_f] = ParOrb2RV(a_f,e_f,i_f,OM_f,om_f,theta_f,mu_Earth);


%% Manovra 1 - CAMBIO PIANO

% Calcolo cambio piano in theta2
[om_2,dV_1A,theta_2A,dV_1B,theta_2B] = CambioPiano(a_i,e_i,i_i,OM_i,om_i,i_f,OM_f,mu_Earth);

% Scelta punto di manovra
if (Pt_cambio_Piano == 0)
    dV_1 = dV_1A;
    theta_2 = theta_2A;
elseif (Pt_cambio_Piano == 1)
    dV_1 = dV_1B;
    theta_2 = theta_2B;
elseif (Pt_cambio_Piano ~= 1) && (Pt_cambio_Piano ~= 0)
    error('input punto di cambio piano non valido')
end

% Calcolo tempo raggiungimento intersezione piani (orbita rossa)
[dt_1a] = CalcoloTempi(a_i,e_i,theta_i,theta_2,mu_Earth);




%% Manovra 2 - CAMBIO ANOMALIA PERICENTRO
    
[dV_2,dt_2,om_3,theta_3,r_anChange] = CambioAnPericentroCircolare(a_i,e_i,om_i,om_f,mu_Earth,Start_AnPeri,Pt_Circ);

% Calcolo tempo su orbita verde
[dt_1b] = CalcoloTempi(a_i,e_i,theta_2,theta_3,mu_Earth);
dt_1 = dt_1a + dt_1b;


%% 3 - CAMBIO FORMA

% Calcolo manovra cambio forma in A
[dV_3,dV_4,dV_tot,dT_4,a_t,e_t,rp_t] = CambioForma(a_i,e_i,om_3,a_f,e_f,om_f,mu_Earth,Start_Bitan);

% Calcolo tempi di trasporto inizio e fine manovra
if (Start_Bitan == 0) && (Start_AnPeri == 0)            % peri-apo
    [dt_3] = CalcoloTempi(a_i,e_i,theta_3,theta_PeriG,mu_Earth);
    [dt_f] = CalcoloTempi(a_f,e_f,theta_ApoG,theta_f,mu_Earth);
    
elseif (Start_Bitan == 1) && (Start_AnPeri == 0)        % apo-peri
    [dt_3] = CalcoloTempi(a_i,e_i,theta_3,theta_ApoG,mu_Earth);
    [dt_f] = CalcoloTempi(a_f,e_f,theta_PeriG,theta_f,mu_Earth);
    
elseif (Start_Bitan == 0) && (Start_AnPeri == 1)        % peri-peri
    [dt_3] = CalcoloTempi(a_i,e_i,theta_3,theta_PeriG,mu_Earth);
    [dt_f] = CalcoloTempi(a_f,e_f,theta_PeriG,theta_f,mu_Earth);

elseif (Start_Bitan == 1) && (Start_AnPeri == 1)        % apo-apo
    [dt_3] = CalcoloTempi(a_i,e_i,theta_3,theta_ApoG,mu_Earth);
    [dt_f] = CalcoloTempi(a_f,e_f,theta_ApoG,theta_f,mu_Earth);
end


%% Costi totali manovra

dV_TOT = abs(dV_1) + abs(dV_2) + dV_tot;
dt_TOT = dt_1 + dt_2 + dt_3 + dT_4 + dt_f;

%% Output video

if (Start_AnPeri == 0) && (Start_Bitan == 0)
    disp(' CambioAnPericentro: om_i --> om_f')
    disp(' CambioForma: Perigeo --> Apogeo')
elseif (Start_AnPeri == 0) && (Start_Bitan == 1)
    disp(' CambioAnPericentro: om_i --> om_f')
    disp(' CambioForma: Apogeo --> Perigeo')    
elseif (Start_AnPeri == 1) && (Start_Bitan == 0)
    disp(' CambioAnPericentro: om_i --> om_f')
    disp(' CambioForma: Perigeo --> Perigeo')
elseif (Start_AnPeri == 1) && (Start_Bitan == 1)
    disp(' CambioAnPericentro: om_i --> om_f')
    disp(' CambioForma: Apogeo --> Apogeo')
end

fprintf('\n Costo totale della manovra: %.4f km/s',dV_TOT)
fprintf('\n Tempo totale della manovra: %.4f s \n',dt_TOT)