function [dV_TOT, dt_TOT] = Function_ManCB(Apocenter_dir, Pt_cambio_AnPericentro, Pt_orbF, normR_a)
% Manovra standard cambio orbita A32
% Elenco manovre eseguite:
%   1) circolarizzazione
%   2) trasferimento biellittico
%   3) cambio forma

%% Verifica variabili di manovra
% direzione biellittica
if ((Apocenter_dir ~= 1) && (Apocenter_dir ~= 0))
    error('Apocenter_dir valore non valido')
end

if ((Pt_cambio_AnPericentro ~= 1) && (Pt_cambio_AnPericentro ~= 0))
    error('Pt_cambio_AnPericentro valore non valido')
end

if ((Pt_orbF ~= 1) && (Pt_orbF ~= 0))
    error('Pt_orbF valore non valido')
end

if (normR_a < 20000)
    error('normR_a minore del raggio di apogeo di Orbita_f')
end

% NOTA: necessario che il punto di manovra si più lontano dell'orbita
%       finale per eseguire correttamente la manovra biellittica


%% Input dati
% Costanti note
mu_Earth = 398600.433;
k = [0 0 1]';

% Parametri orbita iniziale
R_i = [-5183.4184 ; 6189.4459 ; 4334.1737];
V_i = [-5.3130; -4.3350; 0.2136];
[~,~,i_i,OM_i,~,~] = RV2ParOrb(R_i,V_i,mu_Earth);
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

% Calcoli preliminari parametri utili
p_f = a_f * (1 - e_f.^2);
r_pf = p_f / (1 + e_f);
r_af = p_f / (1 - e_f);


%% Manovra 1 - CIRCOLARIZZAZIONE
% circolarizzazione orbita iniziale
[dV_1, r_circ, ~ , ~, om_circ, theta_circ] = Circolarizzazione(R_i, V_i, mu_Earth);

% vettore apocentro
if (Apocenter_dir == 0)
    [R_a] = ApocentroBiellittica(R_i,V_i,R_f,V_f,normR_a);
elseif (Apocenter_dir == 1)
    [R_a] = ApocentroBiellittica(R_i,V_i,R_f,V_f,normR_a);
    R_a = -R_a;
else
    error('Apocenter_dir valore non valido')
end

theta_1 = om_circ + theta_circ;
[theta_1] = RifasAngle(theta_1);


%% Manovra 2 - SPOSTAMENTO in pt Manovra 3
% Calcolo punto di pt Manovra 3
[N_vect] = AsseNodi(R_i,V_i);
anomaly_2 = acos( ( dot( N_vect,(-R_a) ) ) / (norm(-R_a) ));
if ( dot(k,(-R_a)) >= 0 )
    theta_2 = anomaly_2;
elseif ( dot(k,(-R_a)) < 0 )
    theta_2 = (2*pi) - anomaly_2;
end
[theta_2] = RifasAngle(theta_2);

% Calcolo tempo trasporto in pt Manovra 3
[dt_1] = CalcoloTempi(r_circ,0,theta_1,theta_2,mu_Earth);


%% 3 - BIELLITTICA_1
% Calcolo orbita intermedia
a_b = (r_circ + normR_a) / 2;
e_b = 1 - (r_circ/a_b);
om_b = theta_2;

% Calcolo manovra cambio forma circ-biellittica
[~,~,dV_tot1,dt_2,~,~,~] = CambioForma(r_circ,0,om_b,a_b,e_b,om_b,mu_Earth,0);



%% 4 - CAMBIO PIANO
% Calcolo cambio piano in theta3
[om_2,dV_4A,~,~,~] = CambioPiano(a_b,e_b,i_i,OM_i,om_b,i_f,OM_f,mu_Earth);

% Caratterizzazione punto di manovra
dV_4 = dV_4A;



%% 5 - BIELLITTICA_2
% Calcolo orbita intermedia
if (Pt_orbF == 0)
    a_b2 = (r_af + normR_a) / 2;    %arrivo apocentro
    e_b2 = 1 - (r_af/a_b2);
    theta_5 = pi;
    om_3 = om_2 + pi;
elseif (Pt_orbF == 1)
    a_b2 = (r_pf + normR_a) / 2;  %arrivo pericentro
    e_b2 = 1 - (r_pf/a_b2);
    theta_5 = 0;
    om_3 = om_2;
else
    error('input punto di cambio piano non valido')
end

% Calcolo manovra cambio forma biellittica-finale
[~,~,dV_tot2,dt_3,~,~,~] = CambioForma(a_b,e_b,om_2,a_f,e_f,om_3,mu_Earth,1);


%% 6 - CAMBIO PERICENTRO
% Cambio anomalia pericentro finale
[dV_7A,dV_7B,theta_6A,theta_7A,theta_6B,theta_7B,~] = CambioAnPericentro(a_f,e_f,om_3,om_f,mu_Earth,0);

% Scelta punto di manovra
if (Pt_cambio_AnPericentro == 0)
    dV_7 = dV_7A;
    theta_6 = theta_6A;
    theta_7 = theta_7A;
elseif (Pt_cambio_AnPericentro == 1)
    dV_7 = dV_7B;
    theta_6 = theta_6B;
    theta_7 = theta_7B;
elseif (Pt_cambio_AnPericentro ~= 1) && (Pt_cambio_AnPericentro ~= 0)
    error('input punto di cambio piano non valido')
end

[dt_4] = CalcoloTempi(a_f,e_f,theta_5,theta_6,mu_Earth);
[dt_f] = CalcoloTempi(a_f,e_f,theta_7,theta_f,mu_Earth);


%% Costi totali manovra
dV_TOT = abs(dV_1) + dV_tot1 + abs(dV_4) + dV_tot2 + abs(dV_7);
dt_TOT = dt_1 + dt_2 + dt_3 + dt_4 + dt_f;


%% Output video
% if (Pt_orbF == 1)
%     disp(' Arrivo a Perigeo orbita finale')
% elseif (Pt_orbF == 0)
%     disp(' Arrivo ad Apogeo orbita finale')
% end
% fprintf('\n Costo totale della manovra: %.4f km/s',dV_TOT)
% fprintf('\n Tempo totale della manovra: %.4f s \n',dt_TOT)

end