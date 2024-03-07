%clear all
close all
clc

%% DATA INPUT

% vettore PCS solution
SPC_input = [   1     1     1 ; ...
                1     1     0 ; ...
                1     0     1 ; ...
                1     0     0 ; ...
                0     1     1 ; ...
                0     1     0 ; ...
                0     0     1 ; ...
                0     0     0 ; ...
            ];  %Bitan_Type - Pt_plane - Pt_Circ  

SPC_output = [  29742.9834,	6.0347, 179489.9819  ; ...         %   1     1     1
                45991.7548,	5.8243, 267869.7774  ; ...         %   1     1     0
                29742.9834,	8.6529, 257363.0610  ; ...         %   1     0     1
                31899.3985,	8.4425, 269310.6718  ; ...         %   1     0     0
                29634.0096,	6.0325, 178767.1629  ; ...         %   0     1     1
                45882.7810,	5.8221, 267134.1392  ; ...         %   0     1     0
                43726.3659,	8.6506, 378259.3008  ; ...         %   0     0     1
                45882.7810,	8.4402, 387259.8481  ; ...         %   0     0     0
            ];  %[t1,v1,t1*v1; ...; tn,vn,tn*vn]; 

        
%% OPTIMIAL Value
        
        [OptSPC_Time,OptSPC_Time_idx] = min(SPC_output(:,1));
        [OptSPC_Velocity,OptSPC_Velocity_idx] = min(SPC_output(:,2));
        [OptSPC_Tradeoff,OptSPC_Tradeoff_idx] = min(SPC_output(:,3));
        
        
%% PLOT

figure (1)
plot(SPC_output(:,1),SPC_output(:,2),'LineStyle','none','Marker','.','Color','k','MarkerSize',8)      %
hold on

title('Optimization SPC maneuver')
xlabel('dT [sec]')
ylabel('dV [km/s]')
grid on

p1 = plot(SPC_output(OptSPC_Time_idx,1),SPC_output(OptSPC_Time_idx,2),'LineStyle','none','Marker','o','MarkerFaceColor','r','MarkerSize',8);   %
p2 = plot(SPC_output(OptSPC_Velocity_idx,1),SPC_output(OptSPC_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerFaceColor','b','MarkerSize',8);   %
p3 = plot(SPC_output(OptSPC_Tradeoff_idx,1),SPC_output(OptSPC_Tradeoff_idx,2),'LineStyle','none','Marker','d','MarkerFaceColor','g','MarkerSize',6);   %
legend ([p1,p2,p3],{'Best time','Best cost','Trade-off'},'Location','best')
hold off
drawnow

%% VIDEO OUTPUT

disp(' Ottimizzazione deltaT: ')
fprintf('\t dT: %.4f s',SPC_output(OptSPC_Time_idx,1))
fprintf('\n \t dV: %.4f km/s',SPC_output(OptSPC_Time_idx,2))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Start_Bitan = %d',SPC_input(OptSPC_Time_idx,1))
fprintf('\n \t \t Pt_cambio_Piano = %d',SPC_input(OptSPC_Time_idx,2))
fprintf('\n \t \t Pt_Circ = %d \n\n',SPC_input(OptSPC_Time_idx,3))

disp(' Ottimizzazione deltaV: ')
fprintf('\t dT: %.4f s',SPC_output(OptSPC_Velocity_idx,1))
fprintf('\n \t dV: %.4f km/s',SPC_output(OptSPC_Velocity_idx,2))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Start_Bitan = %d',SPC_input(OptSPC_Velocity_idx,1))
fprintf('\n \t \t Pt_cambio_Piano = %d',SPC_input(OptSPC_Velocity_idx,2))
fprintf('\n \t \t Pt_Circ = %d \n\n',SPC_input(OptSPC_Velocity_idx,3))

disp(' Ottimizzazione TradeOff: ')
fprintf('\t dT: %.4f s',SPC_output(OptSPC_Tradeoff_idx,1))
fprintf('\n \t dV: %.4f km/s',SPC_output(OptSPC_Tradeoff_idx,2))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Start_Bitan = %d',SPC_input(OptSPC_Tradeoff_idx,1))
fprintf('\n \t \t Pt_cambio_Piano = %d',SPC_input(OptSPC_Tradeoff_idx,2))
fprintf('\n \t \t Pt_Circ = %d \n\n',SPC_input(OptSPC_Tradeoff_idx,3))
        