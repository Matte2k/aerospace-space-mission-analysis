function [om_f,dV_1A,thetaA,dV_1B,thetaB] = CambioPiano(a_i,e_i,i_i,OM_i,om_i,i_f,OM_f,mu)
%CambioPiano      Calcolo parametri dopo cambio di piano richiesto
%
%  [om_f,dV_1A,theta_A,dV_1B,thetaB] = CambioPiano(a_i,e_i,i_i,OM_i,om_i,i_f,OM_f,mu)
%
%  Formendo i parametri 'a,e,i,OM,om' dell'orbita iniziale, i parametri 
%  'i,OM' dell'orbita finale e il parametro gravitazionale 'mu' di un
%  satellite si calcolano il delta di velocità necessario per compiere la
%  manovra e i parametri 'om,theta' dell'orbita finale in radianti e in
%  gradi
%
%  Input arguments:
%  a        [1x1]     semiasse maggiore            [km]
%  e        [1x1]     eccentricità                 [-]
%  i        [1x1]     inclinazione                 [rad]
%  OM       [1x1]     RAAN                         [rad]
%  om       [1x1]     Anomalia del pericentro      [rad]
%  mu       [1x1]     parametro gravitazionale     [km^3/s^2]
%
%  Output arguments:
%  dV_1     [1x1]     variazione di velocità       [km/s]
%  om       [1x1]     Anomalia del pericentro      [rad]
%  theta    [1x1]     anomalia vera                [ra]
%
%  function by Mildfield Rockets 

% parametri utili
p = a_i*(1-e_i^2);

% Calcolo differenza OM e i
deltaOM = OM_f-OM_i;
deltai = i_f-i_i;


% caso 1
if ((deltaOM>0) && (deltai>0)) || ((deltaOM<0) && (deltai<0))
    alpha=acos(cos(i_i)*cos(i_f)+sin(i_i)*sin(i_f)*cos(deltaOM));
    cosuf=(cos(i_i)-cos(alpha)*cos(i_f))/(sin(alpha)*sin(i_f));
    cosui=(cos(i_f)-cos(alpha)*cos(i_i))/(-sin(alpha)*sin(i_i));
    sinui=(sin(deltaOM)/sin(alpha))*sin(i_f);
    sinuf=(sin(deltaOM)/sin(alpha))*sin(i_i);
    
    u_i = atan2(sinui, cosui);
    u_f = atan2(sinuf, cosuf);
    
    theta = u_i-om_i;
    om_f = u_f-theta;
end

% caso 2
if ((deltaOM>0) && (deltai<0)) || ((deltaOM<0) && (deltai>0))
    alpha=acos(cos(i_i)*cos(i_f)+sin(i_i)*sin(i_f)*cos(deltaOM));
    cosuf=(cos(i_i)-cos(alpha)*cos(i_f))/(-sin(alpha)*sin(i_f));
    cosui=(cos(i_f)-cos(alpha)*cos(i_i))/(sin(alpha)*sin(i_i));
    sinui=(sin(deltaOM)/sin(alpha))*sin(i_f);
    sinuf=(sin(deltaOM)/sin(alpha))*sin(i_i);
    
    u_i = atan2(sinui, cosui);
    u_f = atan2(sinuf, cosuf);
    
    theta = 2*pi-u_i-om_i;
    om_f = 2*pi-u_f-theta;
end

% caso 3
if ((deltaOM > 0) && (deltai == 0))
    alpha=acos(cos(i_i)*cos(i_f)+sin(i_i)*sin(i_f)*cos(deltaOM));
    cosuf=(cos(i_i)-cos(alpha)*cos(i_f))/(sin(alpha)*sin(i_f));
    cosui=(cos(i_f)-cos(alpha)*cos(i_i))/(-sin(alpha)*sin(i_i));
    sinui=(sin(deltaOM)/sin(alpha))*sin(i_f);
    sinuf=(sin(deltaOM)/sin(alpha))*sin(i_i);
    
    u_i = atan2(sinui, cosui);
    u_f = atan2(sinuf, cosuf);
    
    theta = u_i-om_i;
    om_f = u_f-theta;
end

% caso 4
if ((deltaOM < 0) && (deltai == 0))
    alpha=acos(cos(i_i)*cos(i_f)+sin(i_i)*sin(i_f)*cos(deltaOM));
    cosuf=(cos(i_i)-cos(alpha)*cos(i_f))/(-sin(alpha)*sin(i_f));
    cosui=(cos(i_f)-cos(alpha)*cos(i_i))/(sin(alpha)*sin(i_i));
    sinui=(sin(deltaOM)/sin(alpha))*sin(i_f);
    sinuf=(sin(deltaOM)/sin(alpha))*sin(i_i);
    
    u_i = atan2(sinui, cosui);
    u_f = atan2(sinuf, cosuf);
    
    theta = 2*pi-u_i-om_i;
    om_f = 2*pi-u_f-theta;
end

% conclusione
v_thetaA = sqrt(mu/p)*(1+e_i*cos(theta));
dV_1A = 2*v_thetaA*sin(alpha/2);
thetaA = theta;
v_thetaB = sqrt(mu/p)*(1+e_i*cos(theta+pi));
dV_1B = 2*v_thetaB*sin(alpha/2);
thetaB = theta+pi;

% Rifasamento angolo
[om_f] = RifasAngle(om_f);
[thetaA] = RifasAngle(thetaA);
[thetaB] = RifasAngle(thetaB);

end

