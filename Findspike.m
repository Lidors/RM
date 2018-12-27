% Input: data,rmsT
% 
% Data: data as a double variable, (output for LoadData)
% rmsT : an rms threshold : scalar with a sign (e.g -4)
% 
% Output:  spkI 
% 
% spkI:  indexes vector of the local minimums crossing rmsT
% 
% The function finds local minimums (using islocalmin or myloclmin)
% That cross the rmsT.
% The function removing one of two local min if they happen in an interval
% that is less the 20 samples


function spkI=Findspike(data,rmsT)


data=data.*0.195;
rawSig = data(:,1);
sampRate = 20000;                   % Samples per second
msRate = sampRate/1000;             % Samples per millisecond 
HP =300; LP =  6000;
[bbp, abp] = butter(4, [HP LP]/(sampRate/2), 'bandpass');  
linearFilteredSig=filtfilt(bbp, abp, double(rawSig));
chan=linearFilteredSig;

rmsChan=rms(chan).*rmsT;            % chossing treshold

TF = myIslocalmin(chan);
spkI=find((TF==1) & (chan<=rmsChan)& (chan>=rmsChan*2));
 
a=diff(spkI);
b=find(a<20);
spkI(b)=[];

% data=zeros(length(spkI),33);
% for i=1:length(spkI);
%     data(i,:)=chan(spkI(i)-16:1:spkI(i)+16);
% end

% zc=(data<-50);
% zc=sum(zc,2);
% izc=find(zc>9);
% % spkI(iz)=[];
% 
% z=abs(diff(data(:,12:20)));
% z=zscore(z);
% z=sum(z,2);
% iz=find(z<-3);
% spkI([iz;izc])=[];
% 
% data=zeros(length(spkI),33);
% for i=1:length(spkI);
% data(i,:)=chan(spkI(i)-16:1:spkI(i)+16);
% end
% figure;plot(data','Color','b')

end
