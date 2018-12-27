function [Pstim,stimDur]=R2P(raw,stimulation)

stim=raw.*(3.3/2^15).*5.*(2/3.1);       % converting bit signal to volt
[count,bin]=histcounts(stim,1000);      % finding offset
stim=stim-bin(find(count==max(count))); % remuving offset

stimulation=[0,stimulation];
n=length(stimulation);
noise=diff(stimulation)./2;
noise=[noise,noise(end)];

vec=zeros(1,length(stim));
stimDur=zeros(1,n);
for i =1:n-1
    
    vecI=find((stim>stimulation(i+1)-noise(i))&(stim<stimulation(i+1)+noise(i+1)));
    vec(vecI)=i;
end
 
%%
% mascing 3ms after stimuli start and ends 

stimI=find(diff(vec)~=0);
for i=1:length(stimI)
    I=(stimI(i):1:stimI(i)+60);
    vec(I)=-1;
end
%%
for i=1:n
    stimDur(i)=sum(vec==i-1);
end

Pstim=vec;


end


