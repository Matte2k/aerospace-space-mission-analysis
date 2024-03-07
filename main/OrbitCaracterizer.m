function [p,T,E,r_p,r_a] = OrbitCaracterizer(R,V,mu_Earth)
%ORBITCARACTERIZER Summary of this function goes here
%   Detailed explanation goes here
% Parametri orbita iniziale
[a,e,i,OM,om,theta] = RV2ParOrb(R,V,mu_Earth);
    % a_i = 9981.0950
    % e_i = 0.0860
    % i_i = 0.4931
    % om_i = 0.3332
    % OM_i = 0.7423
    % theta_i = 1.1977
R_Earth = 6371;
    
p = a * (1 - e.^2);
r_p = p / (1 + e);
r_a = p / (1 - e);
E = - (mu_Earth) / (2*a);
T = (2*pi) * sqrt((a^3)/mu_Earth);

if ((r_p-R_Earth) > 100)&&((r_p-R_Earth) < 1500)&&((r_a-R_Earth) > 100)&&((r_a-R_Earth) < 1500)
    disp('Orbita LEO')
elseif ((r_p-R_Earth) > 5000)&&((r_p-R_Earth) < 20000)&&((r_a-R_Earth) > 5000)&&((r_a-R_Earth) < 20000)
    disp('Orbita MEO')
elseif ((r_p-R_Earth) > 20000)&&((r_a-R_Earth) > 20000)
    disp('Orbita GEO')
else
    disp('Retire the car')
end

[om]=RifasAngle(om);
[OM]=RifasAngle(OM);
[i]=RifasAngle(i);

if (0 < i) && (i < (pi/2))
    disp('Orbita prograde')
elseif (0 < pi/2) && (i < pi)
    disp('Orbita retrograde')
end
  
fprintf('\n Semiasse maggiore: %.4f km',a)
fprintf('\n Eccentricità: %.4f ',e)
fprintf('\n Inclinazione: %.4f rad',i)
fprintf('\n Anomalia normale: %.4f rad',OM)
fprintf('\n Anomalia di pericentro: %.4f rad',om)
fprintf('\n Anomalia vera: %.4f rad ',theta)
fprintf('\n Semilato retto: %.4f km ',p)
fprintf('\n Periodo: %.4f sec ',T)
fprintf('\n Energia specifica: %.4f km^2/s^2',E)
fprintf('\n Raggio pericentro: %.4f km ',r_p)
fprintf('\n Raggio apocentro: %.4f km \n',r_a)
end

