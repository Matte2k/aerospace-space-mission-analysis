function [deltaV, r_circ, i_circ , OM_circ, om_circ, theta_circ] = Circolarizzazione(R_i, V_i, mu)
%CIRCOLARIZZAZIONE : circolarizza l'orbita iniziale nel theta iniziale
%                    assegnato

%% Dati e conti preliminari

% Norme Dati
R_norm = norm(R_i);
V_norm = norm(V_i);

% Momento angolare
h = cross(R_i,V_i);
h_norm = norm(h);

% Eccentricità
e_vect = ((cross(V_i,h)./mu)) - (R_i ./ R_norm);
e = norm(e_vect);


%% Parametri orbita circolare

[a_i,e_i,i_i,OM_i,om_i,theta_i] = RV2ParOrb(R_i,V_i,mu);
[i_i] = RifasAngle(i_i);
[OM_i] = RifasAngle(OM_i);

p_i = a_i.*(1-e_i.^2) ;
r_circ = norm(R_i);
i_circ = i_i;
om_circ = om_i;

%deltaV
v_theta_i = (sqrt(mu ./ p_i)).*(1 + e_i .* cos(theta_i)) ;
v_rad_i = (sqrt(mu ./ p_i)).*(e_i .* sin(theta_i)) ;

v_circ = sqrt(mu./p_i) ;

deltaV_theta = norm(v_circ - v_theta_i) ;
deltaV_rad = norm(0 - v_rad_i) ;
deltaV = sqrt((deltaV_theta).^2 + (deltaV_rad).^2) ;

% theta_circ
if (dot(R_i,V_i)>=0)
    cos_theta_circ = (dot(e_vect,R_i))/(R_norm * e);
    theta_circ = acos(cos_theta_circ);
end

if (dot(R_i,V_i)<0)
    cos_theta_circ = (dot(e_vect,R_i))./(R_norm * e);
    theta_circ = 2*pi - acos(cos_theta_circ);
end

OM_circ = OM_i;

end