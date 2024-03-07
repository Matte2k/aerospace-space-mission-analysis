function [dt] = CalcoloTempi(a,e,theta_1,theta_2,mu)
%CalcoloTempi   Calcolo tempo tra due anomalie vere
%
%   [dt] = CalcoloTempi(a,e,theta_1,theta_2,mu)
%
%   Definta una orbita ellittica tramite il semi-asse maggiore e l'eccentricità
%   calcolo il tempo necessario per passare dalla posizione theta_1 alla
%   posizione theta_2
%
%   Input arguments:
%   a       [1x1]     semiasse maggiore            [km]
%   e       [1x1]     eccentricità                 [-]
%   theta   [1x1]     anomalia vera                [rad]
%   mu      [1x1]     parametro gravitazionale     [km^3/s^2]
%
%   Output arguments:
%   delta_t [1x1]     tempo tra anomalie           [s]
%
%   function by Mildfield Rockets

% Calcoli utili
T = 2*pi*sqrt(a^3/mu); % Tempo di rivoluzione 

if theta_1 == theta_2
    dt = 0;
end

% calcolo tempo da pericentro alla anomalia vera 1
if theta_1>0 && theta_1<pi
    E1 = 2*atan(sqrt((1-e)/(1+e))*tan(theta_1/2));
    t1 = sqrt(a^3/mu)*(E1-e*sin(E1));
elseif theta_1>pi && theta_1<2*pi
    theta2_1 = 2*pi - theta_1;
    E1 = 2*atan(sqrt((1-e)/(1+e))*tan(theta2_1/2));
    t1 = T-(sqrt(a^3/mu)*(E1-e*sin(E1)));
elseif theta_1 == pi
    t1 = T/2;
elseif theta_1 == 0
    t1 = 0;
end

% calcolo tempo dal pericentro alla anomalia vera 2
if theta_2>0 && theta_2<pi
    E2 = 2*atan(sqrt((1-e)/(1+e))*tan(theta_2/2));
    t2 = sqrt(a^3/mu)*(E2-e*sin(E2));
elseif theta_2>pi && theta_2<2*pi
    theta2_2 = 2*pi - theta_2;
    E2 = 2*atan(sqrt((1-e)/(1+e))*tan(theta2_2/2));
    t2 = T-(sqrt(a^3/mu)*(E2-e*sin(E2)));
elseif theta_2 == pi
    t2 = T/2;
elseif theta_2 == 0
    t2 = 0;
end

% calcolo tempo da anomalia vera 1 ad anomalia vera 2
if theta_1<theta_2
    dt = t2-t1;
elseif theta_1>theta_2
    dt = T+t2-t1;
end

end


