function [R_a] = ApocentroBiellittica(R_i,V_i,R_f,V_f,normR_a)

h_i = cross(R_i,V_i);
h_f = cross(R_f,V_f);

R_int = cross(h_i,h_f);
R_int_norm = R_int / (norm(R_int));
R_a = R_int_norm .* normR_a;

end

