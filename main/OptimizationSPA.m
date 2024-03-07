%clear all
close all
clc

%% DATA INPUT

% vettore PCS solution
SPA_input = [   1     1     1 ; ...
                1     1     0 ; ...
                1     0     1 ; ...
                1     0     0 ; ...
                0     1     1 ; ...
                0     1     0 ; ...
                0     0     1 ; ...
                0     0     0 ; ...
            ];  %Pt_plane - Pt_AnChange -  Bitan_Type 

SPA_output = [  20924.8603,	7.0824,   148198.2305; ...         %   1     1     1
                20815.8865,	7.0802,   147380.6395; ...         %   1     1     0
                30883.7906,	7.0824,   218731.3585; ...         %   1     0     1
                30774.8168,	7.0802,   217891.8579; ...         %   1     0     0
                20924.8603,	9.7006,   202983.6998; ...         %   0     1     1
                34908.2428,	9.6984,   338554.1019; ...         %   0     1     0
                16791.4343,	9.7006,   162886.9875; ...         %   0     0     1
                30774.8168,	9.6984,   298466.4832; ...         %   0     0     0
            ];  %[t1,v1,t1*v1; ...; tn,vn,tn*vn]; 

        
%% OPTIMIAL Value
        
        [OptSPA_Time,OptSPA_Time_idx] = min(SPA_output(:,1));
        [OptSPA_Velocity,OptSPA_Velocity_idx] = min(SPA_output(:,2));
        [OptSPA_Tradeoff,OptSPA_Tradeoff_idx] = min(SPA_output(:,3));
        
        
%% PLOT

figure (1)
plot(SPA_output(:,1),SPA_output(:,2),'LineStyle','none','Marker','.','Color','k','MarkerSize',8)      %
hold on

title('Optimization SPA maneuver')
xlabel('dT [sec]')
ylabel('dV [km/s]')
grid on

p1 = plot(SPA_output(OptSPA_Time_idx,1),SPA_output(OptSPA_Time_idx,2),'LineStyle','none','Marker','o','MarkerFaceColor','r','MarkerSize',8);   %
p2 = plot(SPA_output(OptSPA_Velocity_idx,1),SPA_output(OptSPA_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerFaceColor','b','MarkerSize',8);   %
p3 = plot(SPA_output(OptSPA_Tradeoff_idx,1),SPA_output(OptSPA_Tradeoff_idx,2),'LineStyle','none','Marker','d','MarkerFaceColor','g','MarkerSize',6);   %
legend ([p1,p2,p3],{'Best time','Best cost','Trade-off'},'Location','best')
hold off
drawnow

%% VIDEO OUTPUT

disp(' Ottimizzazione deltaT: ')
fprintf('\t dT: %.4f s',SPA_output(OptSPA_Time_idx,1))
fprintf('\n \t dV: %.4f km/s',SPA_output(OptSPA_Time_idx,2))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Pt_cambio_Piano = %d',SPA_input(OptSPA_Time_idx,1))
fprintf('\n \t \t Pt_cambio_AnPericentro = %d',SPA_input(OptSPA_Time_idx,2))
fprintf('\n \t \t Start_Bitan = %d \n\n',SPA_input(OptSPA_Time_idx,3))

disp(' Ottimizzazione deltaV: ')
fprintf('\t dT: %.4f s',SPA_output(OptSPA_Velocity_idx,1))
fprintf('\n \t dV: %.4f km/s',SPA_output(OptSPA_Velocity_idx,2))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Pt_cambio_Piano = %d',SPA_input(OptSPA_Velocity_idx,1))
fprintf('\n \t \t Pt_cambio_AnPericentro = %d',SPA_input(OptSPA_Velocity_idx,2))
fprintf('\n \t \t Start_Bitan = %d \n\n',SPA_input(OptSPA_Velocity_idx,3))

disp(' Ottimizzazione TradeOff: ')
fprintf('\t dT: %.4f s',SPA_output(OptSPA_Tradeoff_idx,1))
fprintf('\n \t dV: %.4f km/s',SPA_output(OptSPA_Tradeoff_idx,2))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Pt_cambio_Piano = %d',SPA_input(OptSPA_Tradeoff_idx,1))
fprintf('\n \t \t Pt_cambio_AnPericentro = %d',SPA_input(OptSPA_Tradeoff_idx,2))
fprintf('\n \t \t Start_Bitan = %d \n\n',SPA_input(OptSPA_Tradeoff_idx,3))
        