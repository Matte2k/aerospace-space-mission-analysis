%clear all
close all
clc

%% DATA INPUT

% vettore PCS solution
CB_input = [   1     1     1 ; ...
               1     1     0 ; ...
               1     0     1 ; ...
               1     0     0 ; ...
               0     1     1 ; ...
               0     1     0 ; ...
               0     0     1 ; ...
               0     0     0 ; ...
            ];  %Apocenter_dir - Pt_cambio_AnPericentro - Pt_orbF  
        
        
Cpalette_plot = char('#0072BD','#D95319','#EDB120','#7E2F8E','#77AC30','#4DBEEE','#A2142F','#000000');

normR_a_vect = (20000:2000:100000);
CB_normR = zeros(length(normR_a_vect),3);
OptCB_Time_point = zeros(length(CB_input),3);
OptCB_Time_value = zeros(length(CB_input),1);
OptCB_Time_idx = zeros(length(CB_input),1);
OptCB_Velocity_point = zeros(length(CB_input),3);
OptCB_Velocity_value = zeros(length(CB_input),1);
OptCB_Velocity_idx = zeros(length(CB_input),1);
OptCB_Tradeoff_point = zeros(length(CB_input),4);
OptCB_Tradeoff_value = zeros(length(CB_input),1);
OptCB_Tradeoff_idx = zeros(length(CB_input),1);

        
%% OPTIMIAL Value & PLOT

figure (1)

for k = (1:length(CB_input))
    
    for idx = (1:length(normR_a_vect))
        [dV_TOT, dt_TOT] = Function_ManCB(CB_input(k,1), CB_input(k,2), CB_input(k,3), normR_a_vect(idx));
        CB_normR(idx,:) = [dt_TOT, dV_TOT, (dV_TOT*dt_TOT)];
       
    end
    
    [OptCB_Time_value(k),OptCB_Time_idx(k)] = min(CB_normR(:,1));
    OptCB_Time_point(k,1) = CB_normR(OptCB_Time_idx(k),1);
    OptCB_Time_point(k,2) = CB_normR(OptCB_Time_idx(k),2);
    OptCB_Time_point(k,3) = normR_a_vect(1,OptCB_Time_idx(k));
    
    [OptCB_Velocity_value(k),OptCB_Velocity_idx(k)] = min(CB_normR(:,2));
    OptCB_Velocity_point(k,1) = CB_normR(OptCB_Velocity_idx(k),1);
    OptCB_Velocity_point(k,2) = CB_normR(OptCB_Velocity_idx(k),2);
    OptCB_Velocity_point(k,3) = normR_a_vect(1,OptCB_Velocity_idx(k));
    
    [OptCB_Tradeoff_value(k),OptCB_Tradeoff_idx(k)] = min(CB_normR(:,3));
    OptCB_Tradeoff_point(k,1) = CB_normR(OptCB_Tradeoff_idx(k),1);
    OptCB_Tradeoff_point(k,2) = CB_normR(OptCB_Tradeoff_idx(k),2);
    OptCB_Tradeoff_point(k,3) = normR_a_vect(1,OptCB_Tradeoff_idx(k));
    OptCB_Tradeoff_point(k,4) = CB_normR(OptCB_Tradeoff_idx(k),3);
     
    plot3(CB_normR(:,1),CB_normR(:,2),normR_a_vect,'LineStyle','-','Color',Cpalette_plot(k,:))
    hold on
    plot3(CB_normR(OptCB_Time_idx(k),1),CB_normR(OptCB_Time_idx(k),2),normR_a_vect(1,OptCB_Time_idx(k)),'LineStyle','none','Marker','o','Color',Cpalette_plot(k,:))
    plot3(CB_normR(OptCB_Velocity_idx(k),1),CB_normR(OptCB_Velocity_idx(k),2),normR_a_vect(1,OptCB_Velocity_idx(k)),'LineStyle','none','Marker','s','Color',Cpalette_plot(k,:))
    plot3(CB_normR(OptCB_Tradeoff_idx(k),1),CB_normR(OptCB_Tradeoff_idx(k),2),normR_a_vect(1,OptCB_Tradeoff_idx(k)),'LineStyle','none','Marker','d','Color',Cpalette_plot(k,:))
    
end


title('Optimization CB maneuver')
xlabel('dT [sec]')
ylabel('dV [km/s]')
zlabel('R_{apo}[km]')
grid on

[OptCB_Time_TOT,OptCB_Time_idx_TOT] = min(OptCB_Time_point(:,1));
[OptCB_Velocity_TOT,OptCB_Velocity_idx_TOT] = min(OptCB_Velocity_point(:,2));
[OptCB_Tradeoff_TOT,OptCB_Tradeoff_idx_TOT] = min(OptCB_Tradeoff_point(:,4));

p1 = plot3(OptCB_Time_point(OptCB_Time_idx_TOT,1),OptCB_Time_point(OptCB_Time_idx_TOT,2),OptCB_Time_point(OptCB_Time_idx_TOT,3),...
        'LineStyle','none','Marker','o','MarkerFaceColor','r','MarkerSize',8);
p2 = plot3(OptCB_Velocity_point(OptCB_Velocity_idx_TOT,1),OptCB_Velocity_point(OptCB_Velocity_idx_TOT,2),OptCB_Velocity_point(OptCB_Velocity_idx_TOT,3),...
        'LineStyle','none','Marker','s','MarkerFaceColor','b','MarkerSize',8);
p3 = plot3(OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,1),OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,2),OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,3),...
        'LineStyle','none','Marker','d','MarkerFaceColor','g','MarkerSize',6);
legend ([p1,p2,p3],{'Best time','Best cost','Trade-off'},'Location','best')

% view manager
% view ([1 0 0])   
    
hold off
drawnow


%% VIDEO OUTPUT

disp(' Ottimizzazione deltaT: ')
fprintf('\t dT: %.4f ks',OptCB_Time_TOT)
fprintf('\n \t dV: %.4f km/s',OptCB_Time_point(OptCB_Time_idx_TOT,2))
fprintf('\n \t R_{apo}: %.0f km',OptCB_Time_point(OptCB_Time_idx_TOT,3))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Apocenter_direction = %d',CB_input(OptCB_Time_idx_TOT,1))
fprintf('\n \t \t Pt_cambio_AnPeri = %d',CB_input(OptCB_Time_idx_TOT,2))
fprintf('\n \t \t Pt_orbF = %d \n\n',CB_input(OptCB_Time_idx_TOT,3))

disp(' Ottimizzazione deltaV: ')
fprintf('\t dT: %.4f s',OptCB_Velocity_point(OptCB_Velocity_idx_TOT,1))
fprintf('\n \t dV: %.4f km/s',OptCB_Velocity_TOT)
fprintf('\n \t R_{apo}: %.0f km',OptCB_Velocity_point(OptCB_Velocity_idx_TOT,3))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Apocenter_direction = %d',CB_input(OptCB_Velocity_idx_TOT,1))
fprintf('\n \t \t Pt_cambio_AnPeri = %d',CB_input(OptCB_Velocity_idx_TOT,2))
fprintf('\n \t \t Pt_orbF = %d \n\n',CB_input(OptCB_Velocity_idx_TOT,3))

disp(' Ottimizzazione TradeOff: ')
fprintf('\t dT: %.4f s',OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,1))
fprintf('\n \t dV: %.4f km/s',OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,2))
fprintf('\n \t R_{apo}: %.0f km',OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,3))
fprintf('\n \t \t Parametri da inserire:')
fprintf('\n \t \t Apocenter_direction = %d',CB_input(OptCB_Tradeoff_idx_TOT,1))
fprintf('\n \t \t Pt_cambio_AnPeri = %d',CB_input(OptCB_Tradeoff_idx_TOT,2))
fprintf('\n \t \t Pt_orbF = %d \n\n',CB_input(OptCB_Tradeoff_idx_TOT,3))
        