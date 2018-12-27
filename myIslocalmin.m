function TF = myIslocalmin(chan)
deriv=diff(chan);
derivSign=sign(deriv);
TF=(diff(derivSign)==2);
TF=[0;TF;0];
end
