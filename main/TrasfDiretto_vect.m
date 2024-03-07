function [ theta1, theta2, a_T_vect, e_T_vect, i_T,OM_T, om_T_OK, theta1_vect, theta2_vect,deltaV_vect,om_T_NO,om_T_vect,om_T_contr,om_T_OP, Verso_OrbitaT] = TrasfDiretto_vect(mu, a_i, e_i, i_i, om_i, OM_i, theta_i, a_f, e_f, i_f, om_f, OM_f, theta_f)

%   TRASFDIR calcola la manovra di trasferimento diretto fra due punti dati
%
%   Input : parametri orbitali iniziali e finali
%
%
%   Output : paramentri orbitali orbita di trasferimento
%            delta V : costo totale manovr diretta
%
%
%   NOTA: se orbita di partenza e orbita di arrivo puntano allo stesso punto, viene calcolato un
%   trasferimento a singolo impulso tra le due orbite quindi non ci sarà
%   nesssuna orbita di trasferimento e l'unico paramentro di interesse sarà
%   deltaV1

rT = 6471 ; %raggio della Terra in kilometri + 100km di atmosfera

H1_vett = [];

a_T_vect = [] ; % [OUTPUT]
e_T_vect =[] ; % [OUTPUT]
om_T_vect = [] ;
om_T_contr = [] ;
om_T_OP = [] ;
deltaV_vect_i = [];
deltaV_vect_f = [];
deltaV_vect = [] ; % [OUTPUT]
om_T_OK = [] ; % [OUTPUT]
theta1_vect = [] ;
theta2_vect = [] ;

om_T_NO = [] ; % collisione con terra

% om_T_contr = [];  om associati alle eccentricita negative cambiate di segno
% p_T_vect = [] ; % controllo su semilato retto

% VARIABILI:
Verso_OrbitaT = 0;       %variabile verso inclinazione piano trasferimento

%% calcolo piano dell'orbita di trasferimento

% devo caratterizzare il piano su cui giace l'orbita di trasferimento,
% dovrò quindi trovarmi l,inclinazione dell'orbita e la RAAN

I = [1 0 0]';
J = [0 1 0]';
K = [0 0 1]';

% devo quindi trovare un orbita tra theta_i e theta_f

% calcolo r e v finali dai paramentri orbitali

[ri,vi] = ParOrb2RV(a_i,e_i,i_i,OM_i,om_i, theta_i, mu) ;
[rf,vf] = ParOrb2RV(a_f,e_f,i_f,OM_f,om_f, theta_f, mu) ;

ri_norm = norm(ri) ;
rf_norm = norm(rf) ;


h_T = cross(ri,rf); % sarebbe tra r e v ma tanto a noi interessa il verso
if(Verso_OrbitaT == 1)
   h_T = h_T/norm(h_T); % versore h
elseif(Verso_OrbitaT == 0)
    h_T = h_T/norm(h_T); % versore h
    h_T = -h_T;
else
    error('retire the car')
end        
h_T = h_T/norm(h_T); % versore h


i_T = acos(dot(h_T,K)) ; % inclinazione orbita di trasferimento [OUTPUT]

n_T = cross(K,h_T) ;
n_T = n_T/norm(n_T) ; % versore linea dei nodi orbita di trasferimento

OM_T = acos(n_T(1)) ; % [OUTPUT]

if n_T(2) < 0  
    OM_T = 2*pi - OM_T ; % ascensione retta nodo ascendente   
end
 

% ora ho inclinazione orbita di trasferimento e RAAN

%% calcolo orbita

deg_rad = 0.0174533 ;  % 1 grado in radianti

for i = 0:deg_rad:2*pi-deg_rad  % provo con tutti le possibili anomalie del pericentro
    
    om_T = i ;
    
    om_T_vect = [om_T_vect  om_T] ;
    
    % devo trovare l'eccentricità e il semiasse maggiore il che è sbatta
    
    % R = RotPF_GE(i_T, OM_T, om_T); % matrice di rotazione da PF a GE
    
    % Definisco le matrici di rotazione
    R_om = [cos(om_T), sin(om_T), 0; -sin(om_T), cos(om_T), 0; 0, 0, 1];
    R_OM = [cos(OM_T), sin(OM_T), 0; -sin(OM_T), cos(OM_T), 0; 0, 0, 1];
    R_i = [1, 0, 0; 0, cos(i_T), sin(i_T); 0, -sin(i_T), cos(i_T)];
    R = R_om * R_i * R_OM; % vettore rotazione
    R = R' ;
    
    
    e_T_peri = I ; % versore eccentricità nel sistema perifocale
    % nota : vettore non è uguale al versore ;
    
    e_T_GEO = R * e_T_peri ; % VERSORE eccentricità nel sistema GEO
    
    % formula dell'algoritmo RVtoParOrb per trovare theta -->
    % mettere il versore o il vettore eccentricità non cambierebbe nulla
    % poichè vettore = cost*versore
    
    cos_theta1 = (dot(ri, e_T_GEO))/(norm(e_T_GEO) * ri_norm) ;   % costheta iniziale su orbita di trasferimento
    cos_theta2 = (dot(rf, e_T_GEO))/(norm(e_T_GEO) * rf_norm) ;   % costheta finale su orbita di trasferimento
    
    if  ri_norm * cos_theta1 ~= rf_norm * cos_theta2 % verifica che le posizioni iniziale e finale non siano coincidenti ?
        
        % calcolo il vettore eccentricità mettendo a sitema le polari
        % per r2 theta2 e r1 theta1
        
        e_T = (rf_norm - ri_norm) / ( ri_norm*cos_theta1 - rf_norm*cos_theta2 );
        
        % e_T_vect = [e_T_vect e_T ; om_T_vect  om_T] ; facevo check per vedere eccentricita negative rispetto a che omega fossero
        
        if (e_T < 0) % a livello di fisica significa che il versore eccentricità punto verso apocentro --> w = w(con corrispondente) + 180
            % w = w(calcolata con la stessa eccentricita ma positiva) + pi
            % quando quindi consideriamo eccentricità negative è come se considerassimo la corrispondente orbita con eccentricità positiva ma con w aumentata di pi
            % quindi è come se stessimo considerando la stessa orbita per due volte
            
            cos_theta1 = -cos_theta1 ;  % conseguenza: anche i coseni hanno i segni sbagliati
            cos_theta2 = -cos_theta2 ;
            
            e_T_GEO = - e_T_GEO ;
            e_T = - e_T ;
            
            om_T_contr = [om_T_contr om_T]; % omega rispetto a cui ho e_T negativa
            
            om_T = RifasAngle(om_T + pi) ;
            
        end
        
        theta1 = acos(cos_theta1);       % punto iniziale orb di trasferimento [OUTPUT]
        h1_aus = cross(e_T_GEO, ri) ;     % vettore ausiliario che mi serve solamente a definire il piano dell'orbita
        
        % h1_aus = h1_aus/norm(h1_aus) ;     % VERSORE ausiliario che mi serve a identificare piano dell'orbita
        
        % H1_vett = [H1_vett h1_aus];        % controllo per vedere se cambiano con le iterazioni
        
        if dot(h_T,h1_aus) < 0 % altro modo per dire ri*vi < 0 è dire che la velocità radiale vr < 0 cio significa affermare che theta è compreso tra pi e 2*pi
            % ovvero dire che si trovi nel 3 e 4 quadrante
            % h_T è sempre lo stesso h1_aus cambia verso in base alla direzione del pericentro
            
            theta1 = 2*pi - theta1 ;
            
        end
        
        theta2 = acos(cos_theta2); % punto finale orb di trasferimento
        h2_aus = cross(e_T_GEO, rf);
        
        if dot(h_T,h2_aus) < 0
            theta2 = 2*pi - theta2 ;
        end
        
        
        
        % ci sono le eccentricità di tutte le orbite possibili contate però due volte
        % orbita(e_T) = orbita(-e_T) fisicamente
        
        
        if abs(e_T) < 1 % esclude orbite aperte ( parabola e iperbole )
            
            e_T_vect = [e_T_vect e_T] ;  % arrivato qui non ho e_T negative grazie all' if Riga 114 (sono presenti però e_T > 1 , ovvero parabole/iperboli)
            om_T_OK = [om_T_OK om_T] ; % sono gli omeghini associati solo a orbite ellittiche
            
            theta1_vect = [theta1_vect theta1];
            theta2_vect = [theta2_vect theta2];
            
            p_T = ri_norm*(1 + e_T * cos_theta1) ; % semilato retto
            % p_T_vect = [p_T_vect p_T] ; % CHECK
            
            a_T = p_T / (1 - (e_T)^2) ; % semiasse maggiore
            a_T_vect = [a_T_vect a_T] ;
            
            % ho tutti i parametri orbitali dell'orbita di trasferimento
            
            [~,v_trasf_i] = ParOrb2RV(a_T,e_T,i_T,OM_T,om_T, theta1, mu) ;
            [~,v_trasf_f] = ParOrb2RV(a_T,e_T,i_T,OM_T,om_T, theta2, mu) ;
            
            
            dV_iniz = norm(vi - v_trasf_i) ;
            dV_fin = norm(vf - v_trasf_f) ;
            
            deltaV = dV_iniz + dV_fin ;
            
            % deltaV_vect = [deltaV_vect deltaV] ;
            
            % devo verificare che non ci siano intersezioni tra orbita di trasferimento e la terra
            
            rP = p_T/(1+abs(e_T)) ; % raggio pericentro
            
            if rP <= rT
                
                arc = linspace(theta1,theta2,100); % arco percorso
                %[arc]=RifasAngle(arc);
                r_arc = p_T./(1+(e_T.*cos(arc))) ; % distanza satellite nell'arco percorso
                
                if min(r_arc) <= rT
                    om_T_NO = [om_T_NO om_T] ; % omega da non considerare perchè associati a orbite che intersecano la terra
                end
                
            end
            
            deltaV_vect_i = [deltaV_vect_i dV_iniz] ; %deltaV accettabili
            deltaV_vect_f = [deltaV_vect_f dV_fin] ; %deltaV accettabili
            deltaV_vect = [deltaV_vect deltaV] ; %deltaV accettabili
            
        end
        
        if abs(e_T) > 1
            
            om_T_OP = [om_T_OP om_T]; % omega associati a orbite paraboliche e iperboliche
            
        end
        
    end
end

[deltaV_minTOT,deltaV_minTOT_idx]=min(deltaV_vect);
v1=deltaV_vect_i(deltaV_minTOT_idx);
v2=deltaV_vect_f(deltaV_minTOT_idx);
end