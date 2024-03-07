% Manovra standard cambio orbita A32
% Elenco manovre eseguite:
%   1) cambio piano
%   2) cambio anomalia di pericentro
%   3) cambio forma

clear all
close all  
clc

%% Scelta punti di manovra

% cambio piano
Pt_cambio_Piano = 1;     % [0 - 1]


% Cambio anomalia pericentro
Pt_cambio_AnPericentro = 1 ;      % [0 - 1]
    
Start_AnPeri = 0;                 % om_3 = om_f  -->  Start_AnPeri = 0 
                                  % om_3 = om_f + pi  -->  Start_AnPeri = 1

% Cambio forma
Start_Bitan = 0;          %   om_i = om_f  -->  Start_Bitan = 0  -->  Perigeo-Apogeo
                          %   om_i = om_f  -->  Start_Bitan = 1  -->  Apogeo-Perigeo
                          %   om_i = om_f + pi  -->  Start_Bitan = 0  -->  Perigeo-Perigeo
                          %   om_i = om_f + pi  -->  Start_Bitan = 1  -->  Apogeo-Apogeo

% NOTA: funzionamento corretto garantito con 'Start_AnPeri = 1' solo con dati preinseriti

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

% Calcolo tempo raggiungimento intersezione piani
[dt_1] = CalcoloTempi(a_i,e_i,theta_i,theta_2,mu_Earth);


%% Manovra 2 - CAMBIO ANOMALIA PERICENTRO

% Calcolo manovra cambio anomalia di pericentro
[dV_2A,dV_2B,theta_3A,theta_4A,theta_3B,theta_4B,om_3] = CambioAnPericentro(a_i,e_i,om_2,om_f,mu_Earth,Start_AnPeri);

% Scelta punto di manovra
if (Pt_cambio_AnPericentro == 0)
    dV_2 = dV_2A;
    theta_3 = theta_3A;
    theta_4 = theta_4A;
elseif (Pt_cambio_AnPericentro == 1)
    dV_2 = dV_2B;
    theta_3 = theta_3B;
    theta_4 = theta_4B;
elseif (Pt_cambio_AnPericentro ~= 1) && (Pt_cambio_AnPericentro ~= 0)
    error('input punto di cambio piano non valido')
end

% Calcolo tempo raggiungimento punto manovra
[dt_2] = CalcoloTempi(a_i,e_i,theta_2,theta_3,mu_Earth);


%% 3 - CAMBIO FORMA

% Calcolo manovra cambio forma in A
[dV_3,dV_4,dV_tot,dT_4,a_t,e_t,rp_t] = CambioForma(a_i,e_i,om_3,a_f,e_f,om_f,mu_Earth,Start_Bitan);

% Calcolo tempi di trasporto inizio e fine manovra
if (Start_Bitan == 0) && (Start_AnPeri == 0)            % peri-apo
    [dt_3] = CalcoloTempi(a_i,e_i,theta_4,theta_PeriG,mu_Earth);
    [dt_f] = CalcoloTempi(a_f,e_f,theta_ApoG,theta_f,mu_Earth);
    
elseif (Start_Bitan == 1) && (Start_AnPeri == 0)        % apo-peri
    [dt_3] = CalcoloTempi(a_i,e_i,theta_4,theta_ApoG,mu_Earth);
    [dt_f] = CalcoloTempi(a_f,e_f,theta_PeriG,theta_f,mu_Earth);
    
elseif (Start_Bitan == 0) && (Start_AnPeri == 1)        % peri-peri
    [dt_3] = CalcoloTempi(a_i,e_i,theta_4,theta_PeriG,mu_Earth);
    [dt_f] = CalcoloTempi(a_f,e_f,theta_PeriG,theta_f,mu_Earth);

elseif (Start_Bitan == 1) && (Start_AnPeri == 1)        % apo-apo
    [dt_3] = CalcoloTempi(a_i,e_i,theta_4,theta_ApoG,mu_Earth);
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
