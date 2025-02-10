%% RADAR Cross Section Analysis of Radar Targets 

%% Start fresh
clear
close all

%% Model Target (e.g F16)
tgt = platform ; % Define target
tgt.FileName = "F16.stl" ; % Model tgt using its CAD
tgt.Units = "m";
figure
show(tgt);

%% RCS Analysis at VHF, L, S, and X bands
freqs = [0.15e9 1.15e9 3.15e9 8.15e9];
clrM =  ['r' 'b' 'k' 'g'] ;
figure(Position= [54,116,1422,640]);
for idx = 1:length(freqs)
    % Compute RCS
    [rcs_vals, az, ~] =  rcs(tgt, freqs(idx), 0:360, 0, "EnableGPU",true);  % EnableGPU is to accelerate RCS computing
    
    % Plot RCS
    subplot(1,4,idx)
    polarplot(rcs_vals, Color=clrM(idx), LineWidth=1.5)
    title(["RCS @ " + num2str(freqs(idx)/1e9) + " GHz", "RCS Peak = " + num2str(max(rcs_vals) + " dBsm")])
end
sgtitle("RCS Analysis @ VHF, L, S, and X bands", 'Color', 'blue', 'FontSize',20)

%%
