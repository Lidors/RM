% Inputs: path, time, chNum, stimCh, chOfIntrst, stimulation, rmsT.
% 
% path : path to dat file- string 
% Time : time of interests in minutes to be analyzed-
% Time is a vector sized 1 X 2  [start time  end time]
% chNum : number of channels in the recording session (index 0 same as neuroscope)- sclar
% chOfIntrst : channels of interests to be analyzed- scalar or vector (index 0)
% Stimulation : channel number of the stimulation - scalar (index 0)
% rmsT : an rms threshold : scalar with a sign (e.g -4)
% 
% 
% 
% Output: p, r, stimDur.
% 
% 
% P : CDF value of getting that number of spike using a poisson distribution 
% with lambda of r(1) X time of stimulation. 
% (e.g P=1 more spike occurred during stimulation than baseline P=0  less spike
% occurred during stimulation than baseline).
% 1-P = the probability of getting this amount spike by chance.
% P is a vector or a matrix, each row represents a channel and each column represents a stimulus intensity.
% The first column is for the baseline so the P (:,1)=~0.5
% 
% r :  spiking rate per sample r.*20000= average spiking rate of spike/sec
% r is a vector or a matrix, each row represents a channel and each column 
% represents a stimulus intensity.
% The first column is for the baseline
% stimDur :  the total samples for each stimuli and baseline 
% So for all stimulation intensities (assuming theyhave the same time)
% stimDur(2)/stimDur(3)~=1
% stimDur is a vector or a matrix, each row represents a channel and each
% column represents a stimulus intensity.
% The first column is for the baseline
%     
%     Calls
% 
%    FindSpike, LoadData, R2P, SpikeResponse





function [p,r,stimDur]=FindSpikeTH(path,time,chNum,stimCh,chOfIntrst,stimulation,rmsT)

p=zeros(length(chOfIntrst),length(stimulation)+1);
r=zeros(length(chOfIntrst),length(stimulation)+1);
stimDur=zeros(length(chOfIntrst),length(stimulation)+1);

rawstim=LoadData(path,time,chNum,stimCh);
[Pstim,stimDur]=R2P(rawstim,stimulation);
for i=1:length(chOfIntrst)
sig=LoadData(path,time,chNum,chOfIntrst(i));
spkI=Findspike(sig,rmsT);
r(i,:)=SpikeResponse(spkI,Pstim,stimDur);

lambda=r(i,1)*mean(stimDur(2:end));
x=[lambda,r(i,2:end).*(stimDur(2:end))];
p(i,:)= poisscdf(x,lambda) ;

% sd=mean(stimDure(2:end));
% p(i,:)= poisscdf(round(r(i,1)*mean(stimDur(2:end))),r(i,2:end).*(stimDur(2:end))); 
% x = round(r(1)*sd/1.5):1:round(r(1)*sd*1.5);
% y = poisspdf(x,r(1)*sd);
% figure;plot(x,y)
% hold on
% plot(r*sd,ones(length(r)).*max(y)/4,'*')

end
