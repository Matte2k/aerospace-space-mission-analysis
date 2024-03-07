%clear all
close all
clc

%% DATA INPUT

% vettore PAS solution
PAS_input = [   1	1	1	1 ; ...
                1	1	1	0 ; ...
                1	1	0	1 ; ...
                1	1	0	0 ; ...
                1	0	1	1 ; ...
                1	0	1	0 ; ...
                1	0	0	1 ; ...
                1	0	0	0 ; ...
                0	1	1	1 ; ...
                0	1	1	0 ; ...
                0	1	0	1 ; ...
                0	1	0	0 ; ...
                0	0	1	1 ; ...
                0	0	1	0 ; ...
                0	0	0	1 ; ...
                0	0	0	0 ; ...
            ];  %Pt_plane - Pt_AnChange - AnPer_Type - Bitan_Type 

PAS_output = [  32228.4612,	6.6751, 215128.2014; ...         %   1	1	1   1
                26811.6210,	6.7406, 180726.4125; ...         %   1	1	1	0
                17746.5452,	6.6372, 117787.3698; ...         %   1	1	0	1
                31729.9277,	6.6350, 210528.0703; ...         %   1	1	0	0
                41610.9138,	6.6751, 277757.0107; ...         %   1	0	1	1
                26270.2674,	6.7406, 177077.3644; ...         %   1	0	1	0
                26728.0882,	6.6372, 177399.6670; ...         %   1	0	0	1
                30787.6645,	6.6350, 204276.1540; ...         %   1	0	0	0
                42152.2674,	7.5967, 320218.1298; ...         %   0	1	1	1
                36735.4272,	7.6622, 281474.1903; ...         %   0	1	1	0
                27670.3514,	7.5588, 209154.6522; ...         %   0	1	0	1
                41653.7339,	7.5566, 314760.6056; ...         %   0	1	0	0
                41610.9138,	7.5967, 316105.6289; ...         %   0	0	1	1
                26270.2674,	7.6622, 201288.0429; ...         %   0	0	1	0
                26728.0882,	7.5588, 202032.2731; ...         %   0	0	0	1
                30787.6645,	7.5566, 232650.0656; ...         %   0	0	0	0
            ];  %[t1,v1,t1*v1; ...; tn,vn,tn*vn]; 

        
%% OPTIMIAL Value
        
        [OptPAS_Time,OptPAS_Time_idx] = min(PAS_output(:,1));
        [OptPAS_Velocity,OptPAS_Velocity_idx] = min(PAS_output(:,2));
        [OptPAS_Tradeoff,OptPAS_Tradeoff_idx] = min(PAS_output(:,3));
        
        
%% PLOT

figure (1)
plot(PAS_output(:,1),PAS_output(:,2),'LineStyle','none','Marker','.','Color','k','MarkerSize',8)      %
hold on

title('Optimization PAS maneuver')
xlabel('dT [sec]')
ylabel('dV [km/s]')
grid on

p1 = plot(PAS_output(OptPAS_Time_idx,1),PAS_output(OptPAS_Time_idx,2),'LineStyle','none','Marker','o','MarkerFaceColor','r','MarkerSize',8);   %
p2 = plot(PAS_output(OptPAS_Velocity_idx,1),PAS_output(OptPAS_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerFaceColor','b','MarkerSize',8);   %
p3 = plot(PAS_output(OptPAS_Tradeoff_idx,1),PAS_output(OptPAS_Tradeoff_idx,2),'LineStyle','none','Marker','d','MarkerFaceColor','g','MarkerSize',6);   %
legend ([p1,p2,p3],{'Best time','Best cost','Trade-off'},'Location','best')
hold off
drawnow

%% VIDEO OUTPUT

disp(' Ottimizzazione deltaT: ')
fprintf('\t dT: %.4f s',PAS_output(OptPAS_Time_idx,1))
fprintf('\n \t dV: %.4f km/s',PAS_output(OptPAS_Time_idx,2))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Pt_cambio_Piano = %d',PAS_input(OptPAS_Time_idx,1))
fprintf('\n \t \t Pt_cambio_AnPericentro = %d',PAS_input(OptPAS_Time_idx,2))
fprintf('\n \t \t Start_AnPeri = %d',PAS_input(OptPAS_Time_idx,3))
fprintf('\n \t \t Start_Bitan = %d \n\n',PAS_input(OptPAS_Time_idx,4))

disp(' Ottimizzazione deltaV: ')
fprintf('\t dT: %.4f s',PAS_output(OptPAS_Velocity_idx,1))
fprintf('\n \t dV: %.4f km/s',PAS_output(OptPAS_Velocity_idx,2))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Pt_cambio_Piano = %d',PAS_input(OptPAS_Velocity_idx,1))
fprintf('\n \t \t Pt_cambio_AnPericentro = %d',PAS_input(OptPAS_Velocity_idx,2))
fprintf('\n \t \t Start_AnPeri = %d',PAS_input(OptPAS_Velocity_idx,3))
fprintf('\n \t \t Start_Bitan = %d \n\n',PAS_input(OptPAS_Velocity_idx,4))

disp(' Ottimizzazione TradeOff: ')
fprintf('\t dT: %.4f s',PAS_output(OptPAS_Tradeoff_idx,1))
fprintf('\n \t dV: %.4f km/s',PAS_output(OptPAS_Tradeoff_idx,2))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Pt_cambio_Piano = %d',PAS_input(OptPAS_Tradeoff_idx,1))
fprintf('\n \t \t Pt_cambio_AnPericentro = %d',PAS_input(OptPAS_Tradeoff_idx,2))
fprintf('\n \t \t Start_AnPeri = %d',PAS_input(OptPAS_Tradeoff_idx,3))
fprintf('\n \t \t Start_Bitan = %d \n\n',PAS_input(OptPAS_Tradeoff_idx,4))
        