function [dV_A,dV_B,theta_iA,theta_fA,theta_iB,theta_fB,om_end] = CambioAnPericentro(a_i,e_i,om_i,om_f,mu,start)
%CambioAnPericentro     Cambio anomalia di pericentro 
%
%   [dV_A,dV_B,theta_iA,theta_fA,theta_iB,theta_fB,om_end] = CambioAnPericentro(a_i,e_i,om_i,om_f,mu,start)
%
%   Fornendo i parametri 'a,e,om,theta' dell'orbita iniziale, il parametro
%   'om' finale richiesto e il parametro gravitazionale 'mu' di un satellite,
%   si calcola il 'theta_i' in cui eseguire la manovra e il 'theta_f' sull'orbita finale.
%   Scegliere la tipologia di manovra con il parametro 'start':
%
%   Valori 'start':
%   om_end = om_f  -->  start = 0 
%   om_end = om_f + pi  -->  start = 1
%  
%   Input arguments:
%   a_i        [1x1]     semiasse maggiore              [km]
%   e_i        [1x1]     eccentricità                   [-]
%   om_i       [1x1]     Anomalia pericentro iniziale   [rad]
%   om_f       [1x1]     Anomalia pericentro finale     [rad]
%   mu         [1x1]     parametro gravitazionale       [km^3/s^2]
%   start      [1x1]     TBD                            [-]
%
%   Output arguments:
%   dV_A       [1x1]     variazione di velocità manovra in A       [km/s]
%   dV_B       [1x1]     variazione di velocità manovra in B       [km/s]
%   theta_iA   [1x1]     anomalia vera orb iniziale pto. A         [rad]
%   theta_fA   [1x1]     anomalia vera orb finale pto. A           [rad]
%   theta_iB   [1x1]     anomalia vera orb iniziale pto. B         [rad]
%   theta_fB   [1x1]     anomalia vera orb finale pto. B           [rad]
%   om_end     [1x1]     anomalia di pericentro fine manovra       [rad]
%
%   Function by Midfield Rockets

% Calcoli preliminari parametri utili
p = a_i .* (1 - e_i.^2);

if start == 0   
    om_end = om_f;
    delta_om = om_end - om_i;
    
    % Caso manovra in A
    theta_iA = delta_om/2 ;
    theta_fA = 2.*pi - theta_iA ;
    
    %Caso manovra in B
    theta_iB = delta_om/2 + pi;
    theta_fB = 2.*pi - theta_iB;
    
    dV_A = 2.*(sqrt(mu/p)).*e_i.*sin(theta_iA);
    dV_B = 2.*(sqrt(mu/p)).*e_i.*sin(theta_iB);
    
elseif start == 1 
    om_end = om_f + pi;
    delta_om = om_end - om_i;
    
    % Caso manovra in A
    theta_iA = delta_om/2 ;
    theta_fA = 2.*pi - theta_iA ;
    
    %Caso manovra in B
    theta_iB = delta_om/2 + pi;
    theta_fB = 2.*pi - theta_iB;
    
    dV_A = 2.*(sqrt(mu/p)).*e_i.*sin(theta_iA);
    dV_B = 2.*(sqrt(mu/p)).*e_i.*sin(theta_iB);
    
elseif (start ~= 1) && (start ~= 0)
    error('scelta anomalia di pericentro non valida controlla il valore della variabile start')
    
end

% Rifasamento angoli
[theta_iA] = RifasAngle(theta_iA);
[theta_fA] = RifasAngle(theta_fA);
[theta_iB] = RifasAngle(theta_iB);
[theta_fB] = RifasAngle(theta_fB);
[om_end] = RifasAngle(om_end);

end

