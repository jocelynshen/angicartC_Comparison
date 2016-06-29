% method3 is a matlab script to plot the log of the relative frequencies of the
% log of radii of vessels from a data set, then calculate the scaling
% exponent, a, by finding the slope of between the highest frequency radius
% and the lowest frequency radius
%HISTORY	
%	Jocie Shen, 6/23/16, first written
%============================================================
clear all; close all; clc;
A = importdata('ttt.txt');
A = A.data;

arr = [];

for i = 1:length(A)
    if(~isnan(A(i,6)))
        rk = A(i,4);
        arr = [arr rk];
    end
end
%numIntervals = 10;
%intervalWidth = (max(arr)-min(arr))/numIntervals;
%x = min(arr):intervalWidth:max(arr);
%ncount = histc(arr,x);
%relativefreq = ncount/length(arr);
%bar(x-intervalWidth/2, relativefreq, 1)
%xlim([min(x) max(x)]);
%set(gca, 'xtick',x);

bins = logspace(log10(min(arr)), log10(max(arr)));
frequency = [];
for i = 1:length(bins)
    count = 0;
    for a = arr
        if i ==50
            count = 1;
        else if a >= bins(i) && a < bins(i+1)
                count = count + 1;
            end
        end
    end
    frequency = [frequency count];
end
frequency = log(frequency);
bins = log(bins);
y2 = min(find(frequency == max(frequency)));
bar(bins, frequency, 1);
title('Regression-based calculation of a');
xlabel('LOG(radius)') % x-axis label
ylabel('LOG(frequency of the radius)') % y-axis label
x = [bins(y2) bins(50)];
y = [max(frequency) frequency(50)];
hold on;
plot(x,y);
-1/((max(frequency)-frequency(50))/(bins(y2)-bins(50)))
