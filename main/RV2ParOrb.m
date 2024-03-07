function [a,e,i,OM,om,theta] = RV2ParOrb(R,V,mu)
%RV2ParOrb      Calcolo parametri orbitali dati R,V
%   
%   [a,e,i,OM,om,theta] = RV2ParOrb(R,V,mu)
%
%   Fornendo i raggio 'R', velocità 'V' e parametro gravitazionale 'mu' di un satellite si
%   calcolano i parametri orbitali di quest'ultimo
%   Si passa quindi da sistema cartesiano a sistema orbitale
%
%   Input:
%   R       [3x1]   vettore posizione               [km]
%   V       [3x1]   vettore velocità                [km/s]
%   mu      [1x1]   parametro gravitazionale        [km^3/s^2]
%
%   Output:
%   a       [1x1]   semiasse maggiore               [km]
%   e       [1x1]   eccentricità                    [-]
%   i       [1x1]   inclinazione                    [rad]
%   OM      [1x1]   RAAN                            [rad]
%   om      [1x1]   Anomalia del pericentro         [rad]
%   theta   [1x1]   Anomalia vera                   [rad]
%
%   function by Midfield Rockets

%% Dati e conti preliminari

% Assi cartesiani
I = [1,0,0]';
J = [0,1,0]';
K = [0,0,1]';

% Norme Dati
R_norm = norm(R);
V_norm = norm(V);

% Momento angolare
h = cross(R,V);
h_norm = norm(h);

% Eccentricità
e_vect = ((cross(V,h)./mu)) - (R ./ R_norm);
e = norm(e_vect);

% Linea dei nodi
N = (cross(K,h))./(norm(cross(K,h)));
N_norm = norm(N);

%% Calcolo parametri orbitali

% a
a = 1./((2./R_norm)-((V_norm.^2)./mu));

% i
cos_i = dot(h,K)./h_norm;
i = acos(cos_i);

% OM
if (dot(N,J)>=0)
    cos_OM = (dot(I,N))./N_norm;
    OM = acos(cos_OM);
end

if (dot(N,J)<0)
    cos_OM = (dot(I,N))./N_norm;
    OM = 2*pi - acos(cos_OM);
end

% om
if (dot(e_vect,K)>=0)
    cos_om = (dot(e_vect,N))./e;
    om = acos(cos_om);
end

if (dot(e_vect,K)<0)
    cos_om = (dot(e_vect,N))./e;
    om = 2*pi - acos(cos_om);
end
    
% Theta
if (dot(V,R)>=0)
    cos_theta = (dot(R,e_vect))./(e*R_norm);
    theta = acos(cos_theta);
end

if (dot(V,R)<0)
    cos_theta = (dot(R,e_vect))./(e*R_norm);
    theta = 2*pi - acos(cos_theta);
end