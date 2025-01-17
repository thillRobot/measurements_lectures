% ME3023 - Tennessee Technological University
% Tristan Hill - September 15, 2021, September 21, 2022, March 31, 2024
% October 14, 2024
% Data Acquisition - Sampling and Aliasing Demo

function samplingDemo
    
    ap.f_signal=25;
    ap.f_sample=25;

    [t_sig, y_sig, t_sam, y_sam] = simulateSampling(ap.f_signal, ap.f_sample);

    % show the figure
    fig=uifigure
    
    g = uigridlayout(fig);
    g.RowHeight = {'1x','fit'};
    g.ColumnWidth = {'1x'};
    
    % sld=uislider(fig,"value",100);
    ax=uiaxes(g)
    hold(ax,'on')
    p1=plot(ax,t_sig,y_sig,'-')
    p2=plot(ax,t_sam,y_sam,'r-o')
    title(ax,"ME3023 - Sampling Demo")
    xlabel(ax,"time(s)")
    ylabel(ax,"amplitude")
    legend(ax,"Input Signal", "Sampled Signal")

    hold(ax,"off")
    grid(ax,"on")
    
    sld1 = uislider(g, ...
        "Limits",[0 1000], ...
        "Value",[ap.f_signal]);
    
    sld2 = uislider(g, ...
        "Limits",[0 2000], ...
        "Value",[ap.f_sample]);

    sld1.ValueChangingFcn = @(src,event) updateFigure1(src,event,p1,ap,sld1,sld2);

    sld2.ValueChangingFcn = @(src,event) updateFigure2(src,event,p2,ap,sld1,sld2);

end


function updateFigure1(src,event,p1,ap,sld1,sld2)
    ap.f_signal = event.Value;
    ap.f_sample =get(sld2,"value");
    ap.f_signal
    ap.f_sample

    [t_sig, y_sig, t_sam, y_sam] = simulateSampling(ap.f_signal, ap.f_sample);
    p1.set('YData', y_sig)
end

function updateFigure2(src,event,p2,ap,sld1,sld2)
    ap.f_signal =get(sld1,"value")
    ap.f_sample = event.Value;
    ap.f_signal
    ap.f_sample
    [t_sig, y_sig, t_sam, y_sam] = simulateSampling(ap.f_signal, ap.f_sample);

    p2.set('XData', t_sam)
    p2.set('YData', y_sam)
end

function [t_sig, y_sig, t_sam, y_sam] = simulateSampling(f_sig, f_sam)
    
    % simulate a continuous signal
    A_sig=1;
    % f1=1000;
    w_sig=2*pi*f_sig;
    
    t_stop=0.05;
    
    dt_sig=0.00001;
    t_sig=0:dt_sig:t_stop;
    
    y_sig=A_sig*sin(w_sig*t_sig);
    
    % simulate sampling the signal
    dt_sam = 1/f_sam ;
    t_sam=0:dt_sam:t_stop+.00003;
    
    y_sam=A_sig*sin(w_sig*t_sam);

end

