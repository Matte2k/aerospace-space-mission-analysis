close all
clc

%% DATA INPUT

% vettore PCS solution
D_input = [1 0]';
                
D_output = [  1803.9996,	21.4947, 38776.4302021200 ; ...         %   1     
              9668.6036,	7.1734,  69356.7610642400 ];            %   0
              
 %% OPTIMIAL Value
        
        [OptD_Time,OptD_Time_idx] = min(D_output(:,1));
        [OptD_Velocity,OptD_Velocity_idx] = min(D_output(:,2));
        [OptD_Tradeoff,OptD_Tradeoff_idx] = min(D_output(:,3));

%% PLOT        
        
figure (1)
plot(D_output(:,1),D_output(:,2),'LineStyle','none','Marker','.','Color','k','MarkerSize',8)      %
hold on

title('Optimization DIRECT maneuver')
xlabel('dT [sec]')
ylabel('dV [km/s]')
grid on

p1 = plot(D_output(OptD_Time_idx,1),D_output(OptD_Time_idx,2),'LineStyle','none','Marker','o','MarkerFaceColor','r','MarkerSize',8);   %
p2 = plot(D_output(OptD_Velocity_idx,1),D_output(OptD_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerFaceColor','b','MarkerSize',8);   %
p3 = plot(D_output(OptD_Tradeoff_idx,1),D_output(OptD_Tradeoff_idx,2),'LineStyle','none','Marker','d','MarkerFaceColor','g','MarkerSize',6);   %
legend ([p1,p2,p3],{'Best time','Best cost','Trade-off'},'Location','best')
hold off
drawnow