% presets
fig_opts.pos_left=2; % inches
fig_opts.pos_bottom=2; % inches
fig_opts.height=3.91; % inches
fig_opts.width=8.48; % inches
fig_opts.font_name='Futura Bk';
fig_opts.font_size=14; % pt
fig_opts.color_range=parula(6);

close all;

% plots vs time
n=1;
figHandles(n)=figure('Units','inches',...
    'Position',[fig_opts.pos_left+n fig_opts.pos_bottom fig_opts.width fig_opts.height]);
x=log.data.Time/60;
hold on;
% plot(x,log.data.Setpoint,'DisplayName','SP','Color',[0.5 0.5 0.5]);
plot(x,log.data.Pyro,'DisplayName','Pyro','Color',fig_opts.color_range(4,:));
plot(x,log.data.TC1,'DisplayName','TC1','Color',fig_opts.color_range(1,:));
plot(x,log.data.TC2,'DisplayName','TC2','Color',fig_opts.color_range(2,:));
plot(x,log.data.TC3,'DisplayName','TC3','Color',fig_opts.color_range(3,:));
ax=gca;
ax.XLim=[0 inf];
ax.XLabel.String='minutes';
ax.YLim=[0 700];
ax.YLabel.String='°C';
% yyaxis left;
% ax.YColor=fig_opts.color_range(1,:);
ax.Title.String='Temperature vs. Time';
legend('Location','best','Box','off');

% yyaxis right;
% plot(x,log.data.Power,'DisplayName','Power %','Color',fig_opts.color_range(5,:));
% hold off;
% ax=gca;
% ax.YLim=[0 100];
% ax.YLabel.String='%';
% ax.YColor=fig_opts.color_range(5,:);

% Pyro_mV vs TC1
n=n+1;
figHandles(n)=figure('Units','inches','Position',[fig_opts.pos_left+n fig_opts.pos_bottom fig_opts.width fig_opts.height]);
filter(n).array= x>29 & x<48.8 & log.data.TC1>0;
fit(n).coeff = polyfit(log.data.Pyro_mV(filter(n).array),log.data.TC1(filter(n).array),1);
hold on;
plot(log.data.Pyro_mV(filter(n).array),log.data.TC1(filter(n).array),...
    'DisplayName','measurement');
plot(log.data.Pyro_mV(filter(n).array),polyval(fit(n).coeff,log.data.Pyro_mV(filter(n).array)),...
    '--',...
    'DisplayName',['linear fit: TC1 = ' num2str(fit(n).coeff(1),'%.2f') ...
    '°C/mV × ( Pyro - ' num2str(abs(fit(n).coeff(2)/fit(n).coeff(1)),'%.2f') 'mV)']);
hold off;
legend('Location','best','Box','off');
ax=gca;
ax.XLabel.String='Pyrometer (mV)';
ax.XLim=[3000 4500];
ax.YLabel.String='TC1 (°C)';
ax.YLim=[300 550];
ax.Title.String='TC1 vs Pyrometer';

% Pyro vs TC1
n=n+1;
figHandles(n)=figure('Units','inches','Position',...
    [fig_opts.pos_left+n fig_opts.pos_bottom fig_opts.width fig_opts.height]);
filter(n).array= x>29 & x<48.8 & log.data.TC1>0;
fit(n).coeff = polyfit(log.data.Pyro(filter(n).array),...
    log.data.TC1(filter(n).array),1);
hold on;
plot(log.data.Pyro(filter(n).array),log.data.TC1(filter(n).array),...
    'DisplayName','measurement');
plot(log.data.Pyro(filter(n).array),...
    polyval(fit(n).coeff,log.data.Pyro(filter(n).array)),...
    '--',...
    'DisplayName',['linear fit: TC1 = ' num2str(fit(n).coeff(1),'%.2f') ...
    ' × ( Pyro - ' num2str(abs(fit(n).coeff(2)/fit(n).coeff(1)),'%.2f') '°C)']);
hold off;
legend('Location','best','Box','off');
ax=gca;
ax.XLabel.String='Pyrometer (°C)';
% ax.XLim=[3000 4500];
ax.YLabel.String='TC1 (°C)';
% ax.YLim=[300 550];
ax.Title.String='TC1 vs Pyrometer';

% % TC2 and TC3 vs TC1
% n=n+1;
% figHandles(n)=figure('Units','inches','Position',[fig_opts.pos_left+n fig_opts.pos_bottom fig_opts.width fig_opts.height]);
% filter(n).array=(x>0);
% hold on;
% fit(n).coeff = polyfit(log.data.TC1(filter(n).array),log.data.TC2(filter(n).array),1);
% plot(log.data.TC1(filter(n).array),log.data.TC2(filter(n).array),...
%     'DisplayName',['TC2 vs TC1, ~' num2str(fit(n).coeff(1),'%.2f') '×'],...
%     'Color',fig_opts.color_range(2,:));
% % plot(log.data.TC1(filter(n).array),polyval(fit(n).coeff,log.data.TC1(filter(n).array)),':',...
% %     'DisplayName',['TC2 = ' num2str(fit(n).coeff(1),'%.2f') '*TC1 + ' ...
% %     num2str(fit(n).coeff(2),'%.1f')],...
% %     'Color',fig_opts.color_range(2,:));
% fit(n+1).coeff = polyfit(log.data.TC1(filter(n).array),log.data.TC3(filter(n).array),1);
% plot(log.data.TC1(filter(n).array),log.data.TC3(filter(n).array),...
%     'DisplayName',['TC3 vs TC1, ~' num2str(fit(n+1).coeff(1),'%.2f') '×'],...
%     'Color',fig_opts.color_range(3,:));
% % plot(log.data.TC1(filter(n).array),polyval(fit(n+1).coeff,log.data.TC1(filter(n).array)),':',...
% %     'DisplayName',['TC3 = ' num2str(fit(n+1).coeff(1),'%.2f') '*TC1 + ' ...
% %     num2str(fit(n+1).coeff(2),'%.1f')],...
% %     'Color',fig_opts.color_range(3,:));
% hold off;
% ax=gca;
% ax.XLabel.String='TC1 (°C)';
% % ax.XLim=[0 600];
% ax.YLabel.String='TC2 and TC3 (°C)';
% % ax.YLim=[0 600];
% ax.Title.String='TC2 and TC3 vs TC1';
% legend('Location','bestoutside','Box','off');

% % pressure and flow vs time
% n=n+1;
% figHandles(n)=figure('Units','inches','Position',[fig_opts.pos_left+n fig_opts.pos_bottom fig_opts.width fig_opts.height]);
% filter(n).array= x>0;
% hold on;
% plot(x(filter(n).array),log.data.Pressure(filter(n).array),...
%     'DisplayName','Pressure',...
%     'Color',fig_opts.color_range(1,:));
% ax=gca;
% ax.XLabel.String='minutes';
% ax.XLim=[0 inf];
% ax.YLabel.String='mbar';
% ax.YLim=[0 1200];
% yyaxis left;
% ax.YColor=fig_opts.color_range(1,:);
% yyaxis right;
% plot(x(filter(n).array),log.data.O2(filter(n).array),...
%     'DisplayName','Nitrogen Flow',...
%     'Color',fig_opts.color_range(2,:));
% ax.YColor=fig_opts.color_range(2,:);
% ax.YLabel.String='sccm';
% ax.YLim=[0 inf];
% hold off;
% ax.Title.String='Pressure and Flow';
% legend('Location','bestoutside','Box','off');

% calculate some values
n=n+1;
filter(n).target=485;
filter(n).array=(log.data.Setpoint==filter(n).target);
if sum(filter(n).array)>0
    disp(['Set point = ' num2str(filter(n).target,'%.0f') '°C at '...
        num2str(max(x(filter(n).array)),'%.1f') ' minutes in: TC1 = ' ...
        num2str(log.data.TC1(x==max(x(filter(n).array)))) '°C, TC2 = ' ...
        num2str(log.data.TC2(x==max(x(filter(n).array)))) '°C, TC3 = ' ...
        num2str(log.data.TC3(x==max(x(filter(n).array)))) '°C, Pyrometer = ' ...
        num2str(log.data.Pyro(x==max(x(filter(n).array)))) '°C'])
end

% update all figures and all axes
for i=length(figHandles):-1:1
    ax = findall(figHandles(i),'type','axes');
    for j=length(ax):-1:1
        ax(j).FontName=fig_opts.font_name;
        ax(j).FontSize=fig_opts.font_size;
        ax(j).Box='off';
    end
end