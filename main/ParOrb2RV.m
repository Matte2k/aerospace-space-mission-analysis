function [rr,vv] = ParOrb2RV(a,e,i,OM,om,theta,mu)
%ParOrb2RV      Calcolo R,Vti da parametri orbitali
%
%   [rr,vv] = paraorb2rv (a,e,i,OM,om,theta,mu)
%
%   Fornendo i parametri orbitali 'a,e,i,OM,om,theta' e parametro gravitazionale 
%   'mu' di un satellite si calcolano il vettore raggio e velocità
%   Si passa quindi da sistema orbitale a sistema cartesiano
%
%   Input arguments:
%   a       [1x1]     semiasse maggiore            [km]
%   e       [1x1]     eccentricità                 [-]
%   i       [1x1]     inclinazione                 [rad]
%   OM      [1x1]     RAAN                         [rad]
%   om      [1x1]     Anomalia del pericentro      [rad]
%   theta   [1x1]     Anomalia vera                [rad]
%   mu      [1x1]     parametro gravitazionale     [km^3/s^2]
%
%   Output arguments:
%   R       [3x1]        vettore posizion          [km]
%   V       [3x1]        vettore velocità          [km/s]
%
%   function by Midfield Rockets

% Definisco le matrici di rotazione
R_om = [cos(om), sin(om), 0; -sin(om), cos(om), 0; 0, 0, 1];
R_OM = [cos(OM), sin(OM), 0; -sin(OM), cos(OM), 0; 0, 0, 1];
R_i = [1, 0, 0; 0, cos(i), sin(i); 0, -sin(i), cos(i)];
R_rot = R_om * R_i * R_OM; % vettore rotazione

% Parametri utili
p = a .* (1 - e.^2);
r = p ./ (1 + e.* cos(theta));

% Calcolo raggio e velocità perifocale
r_pf = r .* [cos(theta); sin(theta); 0];
v_pf = sqrt(mu/p) .* [-sin(theta); e+cos(theta); 0];

% Passo dai parametri orbitali a rr e vv nelle cordinate GE
rr = (R_rot') * r_pf;
vv = (R_rot') * v_pf;

end

