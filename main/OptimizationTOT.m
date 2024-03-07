clear all
close all
clc

run('OptimizationPAS.m');
run('OptimizationPCS.m');
run('OptimizationSPA.m');
run('OptimizationSPC.m');
run('OptimizationCB.m');
run('OptimizationD.m');
%%
close all
clc

figure(1)

p_PAS = plot3(PAS_output(OptPAS_Time_idx,1),1,PAS_output(OptPAS_Time_idx,2),'LineStyle','none','Marker','^','MarkerFaceColor','r','MarkerSize',5,'MarkerEdgeColor','r');
hold on
plot3(PAS_output(OptPAS_Time_idx,1),1,PAS_output(OptPAS_Time_idx,2),'LineStyle','none','Marker','o','MarkerFaceColor','r','MarkerSize',8,'MarkerEdgeColor','k');
plot3(PAS_output(OptPAS_Velocity_idx,1),1,PAS_output(OptPAS_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerFaceColor','r','MarkerSize',8,'MarkerEdgeColor','k');
plot3(PAS_output(OptPAS_Tradeoff_idx,1),1,PAS_output(OptPAS_Tradeoff_idx,2),'LineStyle','none','Marker','d','MarkerFaceColor','r','MarkerSize',5,'MarkerEdgeColor','k');

p_PCS = plot3(PCS_output(OptPCS_Time_idx,1),2,PCS_output(OptPCS_Time_idx,2),'LineStyle','none','Marker','^','MarkerFaceColor','b','MarkerSize',5,'MarkerEdgeColor','b');
plot3(PCS_output(OptPCS_Time_idx,1),2,PCS_output(OptPCS_Time_idx,2),'LineStyle','none','Marker','o','MarkerFaceColor','b','MarkerSize',8,'MarkerEdgeColor','k');
plot3(PCS_output(OptPCS_Velocity_idx,1),2,PCS_output(OptPCS_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerFaceColor','b','MarkerSize',8,'MarkerEdgeColor','k');
plot3(PCS_output(OptPCS_Tradeoff_idx,1),2,PCS_output(OptPCS_Tradeoff_idx,2),'LineStyle','none','Marker','d','MarkerFaceColor','b','MarkerSize',5,'MarkerEdgeColor','k');

p_SPA = plot3(SPA_output(OptSPA_Time_idx,1),3,SPA_output(OptSPA_Time_idx,2),'LineStyle','none','Marker','^','MarkerFaceColor','#EDB120','MarkerSize',5,'MarkerEdgeColor','#EDB120');
plot3(SPA_output(OptSPA_Time_idx,1),3,SPA_output(OptSPA_Time_idx,2),'LineStyle','none','Marker','o','MarkerFaceColor','#EDB120','MarkerSize',8,'MarkerEdgeColor','k');
plot3(SPA_output(OptSPA_Velocity_idx,1),3,SPA_output(OptSPA_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerFaceColor','#EDB120','MarkerSize',8,'MarkerEdgeColor','k');
plot3(SPA_output(OptSPA_Tradeoff_idx,1),3,SPA_output(OptSPA_Tradeoff_idx,2),'LineStyle','none','Marker','d','MarkerFaceColor','#EDB120','MarkerSize',5,'MarkerEdgeColor','k');

p_SPC = plot3(SPC_output(OptSPC_Time_idx,1),3,SPC_output(OptSPC_Time_idx,2),'LineStyle','none','Marker','^','MarkerFaceColor','c','MarkerSize',5,'MarkerEdgeColor','c');
plot3(SPC_output(OptSPC_Time_idx,1),3,SPC_output(OptSPC_Time_idx,2),'LineStyle','none','Marker','o','MarkerFaceColor','c','MarkerSize',8,'MarkerEdgeColor','k');
plot3(SPC_output(OptSPC_Velocity_idx,1),3,SPC_output(OptSPC_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerFaceColor','c','MarkerSize',8,'MarkerEdgeColor','k');
plot3(SPC_output(OptSPC_Tradeoff_idx,1),3,SPC_output(OptSPC_Tradeoff_idx,2),'LineStyle','none','Marker','d','MarkerFaceColor','c','MarkerSize',5,'MarkerEdgeColor','k');

p_CB = plot3(OptCB_Time_point(OptCB_Time_idx_TOT,1),4,OptCB_Time_point(OptCB_Time_idx_TOT,2),'LineStyle','none','Marker','^','MarkerFaceColor','g','MarkerSize',5,'MarkerEdgeColor','g');
plot3(OptCB_Time_point(OptCB_Time_idx_TOT,1),4,OptCB_Time_point(OptCB_Time_idx_TOT,2),...
        'LineStyle','none','Marker','o','MarkerFaceColor','g','MarkerSize',8,'MarkerEdgeColor','k');          % param: OptCB_Time_point(OptCB_Time_idx_TOT,3)
plot3(OptCB_Velocity_point(OptCB_Velocity_idx_TOT,1),4,OptCB_Velocity_point(OptCB_Velocity_idx_TOT,2),...
        'LineStyle','none','Marker','s','MarkerFaceColor','g','MarkerSize',8,'MarkerEdgeColor','k');          % param: OptCB_Velocity_point(OptCB_Velocity_idx_TOT,3)
plot3(OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,1),4,OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,2),...
        'LineStyle','none','Marker','d','MarkerFaceColor','g','MarkerSize',5,'MarkerEdgeColor','k');          % param: OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,3)

p_D = plot3(D_output(OptD_Time_idx,1),5,D_output(OptD_Time_idx,2),'LineStyle','none','Marker','^','MarkerFaceColor','m','MarkerSize',5,'MarkerEdgeColor','m');    
plot3(D_output(OptD_Time_idx,1),5,D_output(OptD_Time_idx,2),'LineStyle','none','Marker','o','MarkerFaceColor','m','MarkerSize',8,'MarkerEdgeColor','k');
plot3(D_output(OptD_Velocity_idx,1),5,D_output(OptD_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerFaceColor','m','MarkerSize',8,'MarkerEdgeColor','k');
plot3(D_output(OptD_Tradeoff_idx,1),5,D_output(OptD_Tradeoff_idx,2),'LineStyle','none','Marker','d','MarkerFaceColor','m','MarkerSize',5,'MarkerEdgeColor','k');


OptTOT_Time_vect = [OptPAS_Time, OptPCS_Time, OptSPA_Time, OptSPC_Time, OptCB_Time_point(OptCB_Time_idx_TOT,1), OptD_Time];
[OptTOT_Time, OptTOT_Time_idx]= min(OptTOT_Time_vect);
OptTOT_Velocity_vect = [OptPAS_Velocity, OptPCS_Velocity, OptSPA_Velocity, OptSPC_Velocity, OptCB_Velocity_point(OptCB_Velocity_idx_TOT,2), OptD_Velocity];
[OptTOT_Velocity, OptTOT_Velocity_idx]= min(OptTOT_Velocity_vect);
OptTOT_Tradeoff_vect = [OptPAS_Tradeoff, OptPCS_Tradeoff, OptSPA_Tradeoff, OptSPC_Tradeoff, OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,4), OptD_Tradeoff];
[OptTOT_Tradeoff, OptTOT_Tradeoff_idx]= min(OptTOT_Tradeoff_vect);

% switch OptTOT_Time_idx
%     case 1
%         plot3(PAS_output(OptPAS_Time_idx,1),1,PAS_output(OptPAS_Time_idx,2),'LineStyle','none','Marker','o','MarkerSize',12,'MarkerEdgeColor','k');
%     case 2
%         plot3(PCS_output(OptPCS_Time_idx,1),2,PCS_output(OptPCS_Time_idx,2),'LineStyle','none','Marker','o','MarkerSize',12,'MarkerEdgeColor','k');
%     case 3
%         plot3(SPA_output(OptSPA_Time_idx,1),3,SPA_output(OptSPA_Time_idx,2),'LineStyle','none','Marker','o','MarkerSize',12,'MarkerEdgeColor','k');
%     case 4
%         plot3(SPC_output(OptSPC_Time_idx,1),3,SPC_output(OptSPC_Time_idx,2),'LineStyle','none','Marker','o','MarkerSize',12,'MarkerEdgeColor','k');
%     case 5
%         plot3(CB_output(OptCB_Time_idx,1),4,CB_output(OptCB_Time_idx,2),'LineStyle','none','Marker','o','MarkerSize',12,'MarkerEdgeColor','k');
%     case 6
%         plot3(D_output(OptD_Time_idx,1),5,D_output(OptD_Time_idx,2),'LineStyle','none','Marker','o','MarkerSize',12,'MarkerEdgeColor','k');
%     otherwise
%         disp('no power')
% end
%         
% 
% switch OptTOT_Velocity_idx
%     case 1
%         plot3(PAS_output(OptPAS_Velocity_idx,1),1,PAS_output(OptPAS_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerSize',12,'MarkerEdgeColor','k');
%     case 2
%         plot3(PCS_output(OptPCS_Velocity_idx,1),2,PCS_output(OptPCS_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerSize',12,'MarkerEdgeColor','k');
%     case 3
%         plot3(SPA_output(OptSPA_Velocity_idx,1),3,SPA_output(OptSPA_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerSize',12,'MarkerEdgeColor','k');
%     case 4
%         plot3(SPC_output(OptSPC_Velocity_idx,1),3,SPC_output(OptSPC_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerSize',12,'MarkerEdgeColor','k');
%     case 5
%         plot3(CB_output(OptCB_Velocity_idx,1),4,CB_output(OptCB_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerSize',12,'MarkerEdgeColor','k');
%     case 6
%         plot3(D_output(OptD_Velocity_idx,1),5,D_output(OptD_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerSize',12,'MarkerEdgeColor','k');
%     otherwise
%         disp('no power')
% end

switch OptTOT_Tradeoff_idx
    case 1
        p_tradeTOT = plot3(PAS_output(OptPAS_Tradeoff_idx,1),1,PAS_output(OptPAS_Tradeoff_idx,2),'LineStyle','none','Marker','o','MarkerSize',14,'MarkerEdgeColor','b');
    case 2
        p_tradeTOT = plot3(PCS_output(OptPCS_Tradeoff_idx,1),2,PCS_output(OptPCS_Tradeoff_idx,2),'LineStyle','none','Marker','o','MarkerSize',14,'MarkerEdgeColor','b');
    case 3
        p_tradeTOT = plot3(SPA_output(OptSPA_Tradeoff_idx,1),3,SPA_output(OptSPA_Tradeoff_idx,2),'LineStyle','none','Marker','o','MarkerSize',14,'MarkerEdgeColor','b');
    case 4
        p_tradeTOT = plot3(SPC_output(OptSPC_Tradeoff_idx,1),3,SPC_output(OptSPC_Tradeoff_idx,2),'LineStyle','none','Marker','o','MarkerSize',14,'MarkerEdgeColor','b');
    case 5
        p_tradeTOT = plot3(OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,1),4,OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,2),'LineStyle','none','Marker','o','MarkerSize',14,'MarkerEdgeColor','b');
    case 6
        p_tradeTOT = plot3(D_output(OptD_Tradeoff_idx,1),5,D_output(OptD_Tradeoff_idx,2),'LineStyle','none','Marker','o','MarkerSize',14,'MarkerEdgeColor','b');
    otherwise
        disp('no power')
end

%diretta merda
OptTOT_Tradeoff_vect_NODIRECT = [OptPAS_Tradeoff, OptPCS_Tradeoff, OptSPA_Tradeoff, OptSPC_Tradeoff, OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,4)];
[OptTOT_Tradeoff_NODIRECT, OptTOT_Tradeoff_idx_NODIRECT]= min(OptTOT_Tradeoff_vect_NODIRECT);

switch OptTOT_Tradeoff_idx_NODIRECT
    case 1
        p_tradeTOT_NODIRECT = plot3(PAS_output(OptPAS_Tradeoff_idx,1),1,PAS_output(OptPAS_Tradeoff_idx,2),'LineStyle','none','Marker','o','MarkerSize',14,'MarkerEdgeColor','r');
    case 2
        p_tradeTOT_NODIRECT = plot3(PCS_output(OptPCS_Tradeoff_idx,1),2,PCS_output(OptPCS_Tradeoff_idx,2),'LineStyle','none','Marker','o','MarkerSize',14,'MarkerEdgeColor','r');
    case 3
        p_tradeTOT_NODIRECT = plot3(SPA_output(OptSPA_Tradeoff_idx,1),3,SPA_output(OptSPA_Tradeoff_idx,2),'LineStyle','none','Marker','o','MarkerSize',14,'MarkerEdgeColor','r');
    case 4
        p_tradeTOT_NODIRECT = plot3(SPC_output(OptSPC_Tradeoff_idx,1),3,SPC_output(OptSPC_Tradeoff_idx,2),'LineStyle','none','Marker','o','MarkerSize',14,'MarkerEdgeColor','r');
    case 5
        p_tradeTOT_NODIRECT = plot3(OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,1),4,OptCB_Tradeoff_point(OptCB_Tradeoff_idx_TOT,2),'LineStyle','none','Marker','o','MarkerSize',14,'MarkerEdgeColor','r');
    otherwise
        disp('no power')
end

p_time = plot3(PAS_output(OptPAS_Time_idx,1),1,PAS_output(OptPAS_Time_idx,2),'LineStyle','none','Marker','o','MarkerSize',8,'MarkerEdgeColor','k');
p_cost = plot3(PAS_output(OptPAS_Velocity_idx,1),1,PAS_output(OptPAS_Velocity_idx,2),'LineStyle','none','Marker','s','MarkerSize',8,'MarkerEdgeColor','k');
p_trade = plot3(PAS_output(OptPAS_Tradeoff_idx,1),1,PAS_output(OptPAS_Tradeoff_idx,2),'LineStyle','none','Marker','d','MarkerSize',5,'MarkerEdgeColor','k');

%legend ([p_time,p_cost,p_trade, p_PAS, p_PCS, p_SPA, p_SPC, p_CB, p_D, p_tradeTOT, p_tradeTOT_NODIRECT],{'Best time','Best cost','Trade-off','PAS','PCS','SPA','SPC','CB','Direct','Best Trade overall', 'Best Trade overall (No Direct)'},'Location','best')

ylim([1,5]) 
xlabel('dT [sec]')
zlabel('dV [km/s]')
ylabel('Man Type')
grid on
 
 