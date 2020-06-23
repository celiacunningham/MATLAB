% presets
fig_opts.pos_left=2; % inches
fig_opts.pos_bottom=2; % inches
fig_opts.height=3.91; % inches
fig_opts.width=8.48; % inches
fig_opts.font_name='Futura Bk';
fig_opts.font_size=14; % pt

% use Import Data wizard to load the set
report=electricusagereport05232019to06212020;

% plot hourly total vs hour of day
figure('Units','inches',...
    'Position',[fig_opts.pos_left fig_opts.pos_bottom fig_opts.width fig_opts.height]);
plot(timeofday(report.HourofDay),report.HourlyTotal,...
    'LineStyle','none',...
    'Marker','o',...
    'MarkerSize',5,...
    'DurationTickFormat','hh:mm',...
    'DisplayName','all data');

% calculate and plot average
hrs=report.HourofDay(1:24);
for i=24:-1:1
    subset.hour(i)=timeofday(hrs(i));
    subset.usage(i)={report.HourlyTotal(report.HourofDay==hrs(i))};
    subset.n(i)=length(subset.usage{i});
    average(i)=sum(subset.usage{i})/subset.n(i);
end
hold on
plot(timeofday(hrs),average,...
    'LineStyle','-',...
    'LineWidth',0.5,...
    'Marker','o',...
    'MarkerSize',6,...
    'DisplayName','average');
hold off

% format the plot
axis=gca;
axis.YLabel.String=string(report.UnitofMeasurement(1));
axis.Title.String='Hourly Electricity Usage';
axis.FontName=fig_opts.font_name;
axis.FontSize=fig_opts.font_size;
axis.Box='off';
legend('Location','bestoutside','Box','off');