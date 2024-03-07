function [N_vect] = AsseNodi(R_i,V_i)
%ASSENODI       Trova asse nodi
%
%   [N_vect] = AsseNodi(R_i,V_i)
%
%   Fornendo 'R_i' e 'V_i' si ricava l'asse dei dei nodi dell'orbita
%   considerata
%
%   Input:
%   R       [3x1]   vettore posizione               [km]
%   V       [3x1]   vettore velocità                [km/s]
%
%   Output:
%   N_vect       [1x1]   semiasse maggiore               [km]
%
%   function by Midfield Rockets  

z = [0 0 1]';               % asse z
h_i = cross(R_i,V_i);       % vettore momento angolare orbita considerata
N_vect = cross(z,h_i);      % asse dei nodi orbita considerata
N_vect = N_vect/(norm(N_vect));
end

