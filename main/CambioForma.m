function [dV_3,dV_4,dV_tot,dT_4,a_t,e_t,rp_t] = CambioForma(a_i,e_i,om_i,a_f,e_f,om_f,mu,start)
%CambioForma      Calcolo deltaV e deltaT cambio orbita
%   
%   [dV_3,dV_4,dV_tot,dT_4,a_t,e_t,rp_t] = CambioForma(a_i,e_i,om_i,a_f,e_f,om_f,mu,start)
%
%   Fornendo 'mu', i parametri orbitali dell'orbita iniziale e finale di due
%   orbite complanari con anomalia del pericentro uguale o multipla di
%   pigreco. Scegliere la tipologia di manovra con il parametro 'start'
%
%   Valori 'start':
%   om_i = om_f  -->  start = 0  -->  Perigeo-Apogeo
%   om_i = om_f  -->  start = 1  -->  Apogeo-Perigeo
%   om_i = om_f + pi  -->  start = 0  -->  Perigeo-Perigeo
%   om_i = om_f + pi  -->  start = 1  -->  Apogeo-Apogeo
%
%
%   Input:
%   a_i       [1x1]   semiasse maggiore orbita iniziale         [km]
%   e_i       [1x1]   eccentricità orbita iniziale              [-]
%   om_i      [1x1]   anomalia del pericentro orbita iniziale   [rad]
%   a_f       [1x1]   semiasse maggiore orbita finale           [km]
%   e_f       [1x1]   eccentricità orbita finale                [-]
%   om_f      [1x1]   anomalia del pericentro orbita finale     [rad]
%   mu        [1x1]   parametro gravitazionale                  [km^3/s^2]
%   start     [1x1]   punto di partenza della manova            [-]
%
%   Output:
%   dV_3      [1x1]   differenza velocità ingresso orbita trasferimento     [km/s]
%   dV_4      [1x1]   differenza velocità uscita orbita trasferimento       [km/s]
%   dV_tot    [1x1]   differenza velocità totale per manovra                [km/s]
%   dT_4      [1x1]   tempo impiegato per eseguire la manovra               [s]
%   a_t       [1x1]   semiasse maggiore orbita trasferimento                [km]
%   e_t       [1x1]   eccentricità orbita trasferimento                     [km]
%   rp_t      [1x1]   raggio pericentro orbita trasferimento                [km]
%
%   function by Midfield Rockets

% Calcoli preliminari parametri utili
p_i = a_i * (1 - e_i.^2);
p_f = a_f * (1 - e_f.^2);
r_pi = p_i / (1 + e_i);
r_pf = p_f / (1 + e_f);
r_ai = p_i / (1 - e_i);
r_af = p_f / (1 - e_f);
toll = 1e-6;

% Scelta delle manovre
if (om_i == om_f)
    if (start == 0)
        % Manovra da perigeo a apogeo
        
        a_t = (r_pi + r_af) ./ 2;
        if(r_pi < r_af)
           e_t = 1 - (r_pi/a_t);
           rp_t = r_pi;
        elseif (r_pi >= r_af)
           e_t = 1 - (r_af/a_t);
           rp_t = r_af;
        end
        
        v_pi = sqrt(2.* mu .* ( (1./r_pi) - (1./(2.*a_i)) ) );
        v_pt = sqrt(2.* mu .* ( (1./r_pi) - (1./(2.*a_t)) ) );
        v_at = sqrt(2.* mu .* ( (1./r_af) - (1./(2.*a_t)) ) );
        v_af = sqrt(2.* mu .* ( (1./r_af) - (1./(2.*a_f)) ) );
    
        dV_3 = v_pt - v_pi;
        dV_4 = v_af - v_at;
        dV_tot = abs(dV_3) + abs(dV_4);
        
        dT_4 = pi .* sqrt(a_t.^3 ./ mu);
        
    elseif (start == 1)
        % Manovra da apogeo a perigeo
        
        a_t = (r_ai + r_pf) ./ 2;
        if(r_ai < r_pf)
           e_t = 1 - (r_ai/a_t);
           rp_t = r_ai;
        elseif (r_ai >= r_pf)
           e_t = 1 - (r_pf/a_t);
           rp_t = r_pf;
        end
        
        v_ai = sqrt(2.* mu .* ( (1./r_ai) - (1./(2.*a_i)) ) );
        v_at = sqrt(2.* mu .* ( (1./r_ai) - (1./(2.*a_t)) ) );
        v_pt = sqrt(2.* mu .* ( (1./r_pf) - (1./(2.*a_t)) ) );
        v_pf = sqrt(2.* mu .* ( (1./r_pf) - (1./(2.*a_f)) ) );
   
        dV_3 = v_at - v_ai;
        dV_4 = v_pf - v_pt;
        dV_tot = abs(dV_3) + abs(dV_4);
        
        dT_4 = pi .* sqrt(a_t.^3 ./ mu);
        
    elseif (start ~= 1) && (start ~= 0)
        error('punto partenza manovra non valido controlla il valore della variabile start')
    end
end

if (((wrapTo2Pi(om_i - (om_f - pi)))<= toll) || ((wrapTo2Pi(om_i - (om_f + pi)))<= toll))
    if (start == 1)
        % Manovra da apogeo a apogeo
        a_t = (r_ai + r_af) ./ 2;
        if(r_ai < r_af)
           e_t = 1 - (r_ai/a_t);
           rp_t = r_ai;
        elseif (r_ai >= r_af)
           e_t = 1 - (r_af/a_t);
           rp_t = r_af;
        end
        
        v_ai = sqrt(2.* mu .* ( (1./r_ai) - (1./(2.*a_i)) ) );
        v_pt = sqrt(2.* mu .* ( (1./r_ai) - (1./(2.*a_t)) ) );
        v_at = sqrt(2.* mu .* ( (1./r_af) - (1./(2.*a_t)) ) );
        v_af = sqrt(2.* mu .* ( (1./r_af) - (1./(2.*a_f)) ) );
    
        dV_3 = v_pt - v_ai;
        dV_4 = v_af - v_at;
        dV_tot = abs(dV_3) + abs(dV_4);
        
        dT_4 = pi .* sqrt(a_t.^3 ./ mu);
        
    elseif (start == 0)
        % Manovra da perigeo a perigeo
        a_t = (r_pi + r_pf) ./ 2;
        if(r_pi < r_pf)
           e_t = 1 - (r_pi/a_t);
           rp_t = r_pi;
        elseif (r_pi >= r_pf)
           e_t = 1 - (r_pf/a_t);
           rp_t = r_pf;
        end
        
        v_pi = sqrt(2.* mu .* ( (1./r_pi) - (1./(2.*a_i)) ) );
        v_at = sqrt(2.* mu .* ( (1./r_pi) - (1./(2.*a_t)) ) );
        v_pt = sqrt(2.* mu .* ( (1./r_pf) - (1./(2.*a_t)) ) );
        v_pf = sqrt(2.* mu .* ( (1./r_pf) - (1./(2.*a_f)) ) );
   
        dV_3 = v_at - v_pi;
        dV_4 = v_pf - v_pt;
        dV_tot = abs(dV_3) + abs(dV_4);
        
        dT_4 = pi .* sqrt(a_t.^3 ./ mu);
        
    elseif (start ~= 1) && (start ~= 0)
        error('punto partenza manovra non valido controlla il valore della variabile start')
    end
end

end