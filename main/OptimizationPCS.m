%clear all
close all
clc

%% DATA INPUT

% vettore PCS solution
PCS_input = [   1	1	1	1 ; ...
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

PCS_output = [  39623.3287,	6.6894, 265056.2950  ; ...         %   1    1	 1   1
                24282.6823, 6.7549, 164027.0906  ; ...         %   1	1	 1	 0
                25536.5020, 6.2476, 159541.8498  ; ...         %   1	1	 0	 1
                29596.0783, 6.2454, 184839.3474  ; ...         %   1	1	 0	 0
                41395.1486, 6.6659, 275935.9210  ; ...         %   1	0	 1	 1
                35978.3084, 6.7314, 242184.3851  ; ...         %   1	0	 1	 0
                26029.2462, 6.2241, 162008.6312  ; ...         %   1	0	 0	 1
                40012.6287, 6.2219, 248954.5745  ; ...         %   1	0	 0	 0
                49547.1349, 7.6109, 377098.2890  ; ...         %   0	1	 1	 1
                34206.4885, 7.6765, 262586.1089  ; ...         %   0	1	 1	 0
                35460.3082, 7.1692, 254222.0415  ; ...         %   0	1	 0	 1
                39519.8845, 7.1670, 283239.0122  ; ...         %   0	1	 0	 0
                41395.1486, 7.5874, 314081.5504  ; ...         %   0	0	 1	 1
                35978.3084, 7.6530, 275341.9941  ; ...         %   0	0	 1	 0
                26029.2462, 7.1457, 185997.1845  ; ...         %   0	0	 0	 1
                40012.6287, 7.1435, 285830.2131  ; ...         %   0	0	 0	 0
            ];  %[t1,v1,t1*v1; ...; tn,vn,tn*vn]; 

        
%% OPTIMIAL Value
        
        [OptPCS_Time,OptPCS_Time_idx] = min(PCS_output(:,1));
        [OptPCS_Velocity,OptPCS_Velocity_idx] = min(PCS_output(:,2));
        [OptPCS_Tradeoff,OptPCS_Tradeoff_idx] = min(PCS_output(:,3));
        
        
%% PLOT

figure (1)
plot(PCS_output(:,1),PCS_output(:,2),'LineStyle','none','Marker','.','Color','k','MarkerSize',8)      %
hold on

title('Optimization PCS maneuver')
xlabel('dT [sec]')
ylabel('dV [km/s]')
grid on

p1 = plot(PCS_output(OptPCS_Time_idx,1),PCS_output(OptPCS_Time_idx,2),'LineStyle','none','Marker','o','MarkerFaceColor','r','MarkerSize',8);   %
p2 = plot(PCS_output(OptPCS_Velocity_idx,1),PCS_output(OptPCS_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerFaceColor','b','MarkerSize',8);   %
p3 = plot(PCS_output(OptPCS_Tradeoff_idx,1),PCS_output(OptPCS_Tradeoff_idx,2),'LineStyle','none','Marker','d','MarkerFaceColor','g','MarkerSize',6);   %
legend ([p1,p2,p3],{'Best time','Best cost','Trade-off'},'Location','best')
hold off
drawnow

%% VIDEO OUTPUT

disp(' Ottimizzazione deltaT: ')
fprintf('\t dT: %.4f s',PCS_output(OptPCS_Time_idx,1))
fprintf('\n \t dV: %.4f km/s',PCS_output(OptPCS_Time_idx,2))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Pt_cambio_Piano = %d',PCS_input(OptPCS_Time_idx,1))
fprintf('\n \t \t Pt_cambio_AnPericentro = %d',PCS_input(OptPCS_Time_idx,2))
fprintf('\n \t \t Start_AnPeri = %d',PCS_input(OptPCS_Time_idx,3))
fprintf('\n \t \t Start_Bitan = %d \n\n',PCS_input(OptPCS_Time_idx,4))

disp(' Ottimizzazione deltaV: ')
fprintf('\t dT: %.4f s',PCS_output(OptPCS_Velocity_idx,1))
fprintf('\n \t dV: %.4f km/s',PCS_output(OptPCS_Velocity_idx,2))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Pt_cambio_Piano = %d',PCS_input(OptPCS_Velocity_idx,1))
fprintf('\n \t \t Pt_cambio_AnPericentro = %d',PCS_input(OptPCS_Velocity_idx,2))
fprintf('\n \t \t Start_AnPeri = %d',PCS_input(OptPCS_Velocity_idx,3))
fprintf('\n \t \t Start_Bitan = %d \n\n',PCS_input(OptPCS_Velocity_idx,4))

disp(' Ottimizzazione TradeOff: ')
fprintf('\t dT: %.4f s',PCS_output(OptPCS_Tradeoff_idx,1))
fprintf('\n \t dV: %.4f km/s',PCS_output(OptPCS_Tradeoff_idx,2))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Pt_cambio_Piano = %d',PCS_input(OptPCS_Tradeoff_idx,1))
fprintf('\n \t \t Pt_cambio_AnPericentro = %d',PCS_input(OptPCS_Tradeoff_idx,2))
fprintf('\n \t \t Start_AnPeri = %d',PCS_input(OptPCS_Tradeoff_idx,3))
fprintf('\n \t \t Start_Bitan = %d \n\n',PCS_input(OptPCS_Tradeoff_idx,4))
        