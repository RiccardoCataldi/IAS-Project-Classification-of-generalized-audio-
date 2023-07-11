function [] = plot_kNN(lines, columns, slotPlot, k, rate, titleSubplot)
% plot performance / k
subplot(lines,columns,slotPlot)
plot(k,rate)
title(titleSubplot)
xlabel('number of neighbors')
ylabel('performance (%)')
grid on