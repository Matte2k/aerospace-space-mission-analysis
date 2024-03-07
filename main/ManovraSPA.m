% Manovra SPA
% Elenco manovre eseguite:
%   1) cambio forma
%   2) cambio piano
%   3) cambio anomalia di pericentro

clear all
close all
clc

%% Scelta punti di manovra

% cambio piano
Pt_cambio_Piano = 0 ;     % [0 - 1]


% Cambio anomalia pericentro
Pt_cambio_AnPericentro = 0 ;      % [0 - 1]


% Cambio forma
Start_Bitan = 1;          %   om_i = om_f  -->  Start_Bitan = 0  -->  Perigeo-Apogeo
                          %   om_i = om_f  -->  Start_Bitan = 1  -->  Apogeo-Perigeo

% NOTA: Start_AnPeri = 0 -> cambio forma considerato solo senza cambiare anomalia pericentro

%% Input dati

% Costanti note
mu_Earth = 398600.433;
R_Earth = 6378.14;
theta_PeriG = 0;
theta_ApoG = pi;
Start_AnPeri = 0;

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


%% Manovra 1 - CAMBIO FORMA

% Calcolo manovra cambio forma in A
[dV_01,dV_02,dV_1,dt_2,a_t,e_t,rp_t] = CambioForma(a_i,e_i,om_i,a_f,e_f,om_i,mu_Earth,Start_Bitan);

% Calcolo tempi di trasporto inizio e fine manovra
if (Start_Bitan == 0) && (Start_AnPeri == 0)            % peri-apo
    [dt_1] = CalcoloTempi(a_i,e_i,theta_i,theta_PeriG,mu_Earth);
    theta_2 = theta_ApoG;
    
elseif (Start_Bitan == 1) && (Start_AnPeri == 0)        % apo-peri
    [dt_1] = CalcoloTempi(a_i,e_i,theta_i,theta_ApoG,mu_Earth);
    theta_2 = theta_PeriG;
    
end

%% Manovra 2 - CAMBIO PIANO

% Calcolo cambio piano in theta2
[om_2,dV_2A,theta_3A,dV_2B,theta_3B] = CambioPiano(a_f,e_f,i_i,OM_i,om_i,i_f,OM_f,mu_Earth);

% Scelta punto di manovra
if (Pt_cambio_Piano == 0)
    dV_2 = dV_2A;
    theta_3 = theta_3A;
elseif (Pt_cambio_Piano == 1)
    dV_2 = dV_2B;
    theta_3 = theta_3B;
elseif (Pt_cambio_Piano ~= 1) && (Pt_cambio_Piano ~= 0)
    error('input punto di cambio piano non valido')
end

% Calcolo tempo raggiungimento intersezione piani
[dt_3] = CalcoloTempi(a_f,e_f,theta_2,theta_3,mu_Earth);

%% Manovra 3 - CAMBIO ANOMALIA PERICENTRO

% Calcolo manovra cambio anomalia di pericentro
[dV_3A,dV_3B,theta_4A,theta_5A,theta_4B,theta_5B,om_3] = CambioAnPericentro(a_f,e_f,om_2,om_f,mu_Earth,Start_AnPeri);

% Scelta punto di manovra
if (Pt_cambio_AnPericentro == 0)
    dV_3 = dV_3A;
    theta_4 = theta_4A;
    theta_5 = theta_5A;
elseif (Pt_cambio_AnPericentro == 1)
    dV_3 = dV_3B;
    theta_4 = theta_4B;
    theta_5 = theta_5B;
elseif (Pt_cambio_AnPericentro ~= 1) && (Pt_cambio_AnPericentro ~= 0)
    error('input punto di cambio piano non valido')
end

% Calcolo tempo raggiungimento punto manovra
[dt_4] = CalcoloTempi(a_f,e_f,theta_3,theta_4,mu_Earth);

% Calcolo tempo raggiungimento punto finale
[dt_f] = CalcoloTempi(a_f,e_f,theta_5,theta_f,mu_Earth);

%% Costi totali manovra

dV_TOT = abs(dV_1) + abs(dV_2) + abs(dV_3);
dt_TOT = dt_1 + dt_2 + dt_3 + dt_4 + dt_f;

%% Output video

if (Start_AnPeri == 0) && (Start_Bitan == 0)
    disp(' CambioAnPericentro: om_i --> om_f')
    disp(' CambioForma: Perigeo --> Apogeo')
elseif (Start_AnPeri == 0) && (Start_Bitan == 1)
    disp(' CambioAnPericentro: om_i --> om_f')
    disp(' CambioForma: Apogeo --> Perigeo')    
elseif (Start_AnPeri == 1) && (Start_Bitan == 0)
    error('input punto di cambio anomalia pericentro non valido')
elseif (Start_AnPeri == 1) && (Start_Bitan == 1)
    error('input punto di cambio anomalia pericentro non valido')
end

fprintf('\n Costo totale della manovra: %.4f km/s',dV_TOT)
fprintf('\n Tempo totale della manovra: %.4f s \n',dt_TOT)