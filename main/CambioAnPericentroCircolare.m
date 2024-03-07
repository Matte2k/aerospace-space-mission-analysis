function [dV,dt,om_end,theta_f,r] = CambioAnPericentroCircolare(a_i,e_i,om_i,om_f,mu_Earth,start_AnPeri,Pt_Circ)
%CambioAnPericentroCircolare  Cambio di anomalia di pericentro metodo alternativo 
%
%   [dV,dt,om_end,theta_f,r] = CambioAnPericentroCircolare(a_i,e_i,om_i,om_f,mu_Earth,start_AnPeri,Pt_Circ)
%
%   Fornendo i parametri 'a,e,om' dell'orbita iniziale, il parametro
%   'om' finale richiesto e il parametro gravitazionale 'mu' di un satellite,
%   passo da un'orbita all'altra cambiando il parametro om usando un'orbita
%   di traferimento circolare che ci porta, in base al parametro Pt_Circ,
%   dal pericecentro al pericentro o dall'apocentro all'apocentro
%
%   Valori 'start_AnPeri':
%   om_end = om_f  -->  start = 0 
%   om_end = om_f + pi  -->  start = 1
%
%   Valori 'Pt_Circ':
%   Pt_Circ = 0  -->  Manovro su apocentri 
%   Pt_Circ = 1  -->  Manovro su pericentri
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
%   dV         [1x1]     variazione di velocità manovra            [km/s]
%   dt         [1x1]     variazione del tempo                      [s]
%   theta_f    [1x1]     anomalia vera orb finale                  [rad]
%   om_end     [1x1]     anomalia di pericentro fine manovra       [rad]
%   r          [1x1]     raggio orbita circolare                   [km]
%
%   Function by Midfield Rockets

% parametri utili nuova orbita
p = a_i*(1-e_i^2);
r_apo = a_i*(1+e_i);
r_peri = a_i*(1-e_i);

if start_AnPeri == 0   
    om_end = om_f;
    [om_end]=RifasAngle(om_end);
    [om_i]=RifasAngle(om_i);
    delta_om = om_end - om_i;
    
    % calcolo circolarizzazione
    if Pt_Circ == 0     %circolarizzo nel apocentro
        V_i = sqrt(mu_Earth/p)*(1-e_i);
        Vc = sqrt(mu_Earth/r_apo);
        dV_i = V_i - Vc;
        r = r_apo;
        theta_f = pi;


    elseif Pt_Circ == 1 %circolarizzo nel pericentro
        V_i = sqrt(mu_Earth/p)*(1+e_i);
        Vc = sqrt(mu_Earth/r_peri);
        dV_i = Vc - V_i;
        r = r_peri;
        theta_f = 0;
    end

    dV = 2*dV_i;
    dt = delta_om*(sqrt((r^3)/mu_Earth));
end


if start_AnPeri == 1  
    om_end = om_f + pi;
    [om_end]=RifasAngle(om_end);
    [om_i]=RifasAngle(om_i);
    delta_om = om_end - om_i;
    
    % calcolo circolarizzazione
    if Pt_Circ == 0     %circolarizzo nel apocentro
        V_i = sqrt(mu_Earth/p)*(1-e_i);
        Vc = sqrt(mu_Earth/r_apo);
        dV_i = V_i - Vc;
        r = r_apo;
        theta_f = pi;


    elseif Pt_Circ == 1 %circolarizzo nel pericentro
        V_i = sqrt(mu_Earth/p)*(1+e_i);
        Vc = sqrt(mu_Earth/r_peri);
        dV_i = Vc - V_i;
        r = r_peri;
        theta_f = 0;
    end

    dV = 2*dV_i;
    dt = delta_om*(sqrt((r^3)/mu_Earth));
end

[om_end] = RifasAngle(om_end);

end