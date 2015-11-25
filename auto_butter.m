% Copyright (C) 2015  Devin C Prescott
function [yf] = auto_butter(y,t,show_plot,freq,type,n)
%% Simple Butterworth Filter
% This function attempts to automatically filter noise out of input data.
% Future work should allow the user to select the frequencies they would
% like to extract
    
%% FFT Setup
if iscell(y)==0
    y = {y};
    t = {t};
end
n_plots = length(y);
total_time=zeros(n_plots,1);
Fs=zeros(n_plots,1);
for i = 1:n_plots
    L(i) = length(y{i});
    total_time(i) = abs(t{i}(1)-t{i}(end));
    Fs(i) = length(y{i})/total_time(i);
    NFFT(i) = 2^nextpow2(L(i));
    Y{i} = fft(y{i},NFFT(i))/L(i);
    f{i} = Fs(i)/2*linspace(0,1,NFFT(i)/2+1);
end

%% Plot
if show_plot
    figure;
    if n_plots == 1
        plot(f{1},2*abs(Y{1}(1:NFFT(1)/2+1)))
    elseif n_plots <= 4
        for i = 1:n_plots
            subplot(2,2,i),plot(f{i},2*abs(Y{i}(1:NFFT(i)/2+1)));
        end
    elseif n_plots <= 9
        for i = 1:n_plots
            subplot(3,3,i),plot(f{i},2*abs(Y{i}(1:NFFT(i)/2+1)));
        end
    elseif n_plots <= 16
        for i = 1:n_plots
            subplot(4,4,i),plot(f{i},2*abs(Y{i}(1:NFFT(i)/2+1)));
        end
    elseif n_plots <= 25
        for i = 1:n_plotsF
            subplot(5,5,i),plot(f{i},2*abs(Y{i}(1:NFFT(i)/2+1)));
        end
    end
end

%% Filter Setup
%% Input Filter Freq
if freq > -1
    f = freq;
    ftype = type;
    for i = 1:n_plots
        Wn{i} = f/(Fs(i)/2);
        [b{i},a{i}] = butter(n,Wn{i},ftype);
    end
else
    n = 3;
    ftype = 'low';
    for i = 1:n_plots
        fft_amp = 2*abs(Y{i}(1:NFFT(i)/2+1));
        freq_ind = find(fft_amp>0.01*max(fft_amp),1,'last');
        Wn{i} = f{i}(freq_ind)/(Fs(i)/2);
        [b{i},a{i}] = butter(n,Wn{i},ftype);
    end
end
%% Filter Data
for i = 1:n_plots
    yf{i} = filter(b{i},a{i},y{i});
    if show_plot
    figure;plot(t{i},y{i},t{i},yf{i},'r')
    end
end