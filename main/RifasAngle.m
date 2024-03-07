function [angle] = RifasAngle(angle)
%RifasAngle     Rifasamento angoli tra 0 e 2pi
%   
%   [angle] = RifasAngle(angle)
%
%   Formendo un angolo 'angle' in radianti si rifasa nell'intervallo 0 2pi
%
%   function by Mildfield Rockets

if (angle < 0)
    angle = (2*pi) + angle;
elseif (angle > 2*pi)
    angle = angle - 2*pi;
end

end

