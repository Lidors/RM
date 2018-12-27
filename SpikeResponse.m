function r=SpikeResponse(spkI,Pstim,stimDur)

n=length(stimDur);
r=zeros(1,n);
for i=0:n-1
    a=sum(Pstim(spkI)==i);
    r(i+1)=a/stimDur(i+1);
end

end