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
