# RM
FindSpikeTH 
MATLAB Function

test

The FindSpikeTH MATLAB function compares the number of spikes that occur during different stimulation intensities and at baseline. The function then returns the P-value of getting this number of spikes by chance (the null hypothesis assumes that the stimulation does not affect the spiking rate).

The results of this function are based on three main assumptions:
SISO - single in single out;
Parameters set by the user only;
Detectable spikes.

SISO

The function assumes that there is only one stimulation source.
The function detects spikes for each channel without taking into account other recording sites.
In practice one should input to the function only one stimulation signal, and make sure that  there are no other stimulations during that time.   
 

Parameters

Currently the function assumes that the stimulation is a square pulse stimulation in different intensities.
That means that other types of stimulation (sine, ramp WN) will not cause an error, but will produce unreliable results.
Users should also know, that the function is heavily dependant on the user input.
That means that there is no default parameters, and in cases when the user does not give one or more of the inputs, or if there is a mistake in one of the inputs the function will not work properly.
The function assumes that all stimulations intsenty are given evenly (e.g have the same total duration of stimulation)

Spikes 

The function compares the number of spikes that occurs in different times (stimulation and baseline). To do so, spikes must be detectable.
That means that the user can  see spikes, otherwise the results will have no meaning.






FindSpikeTH

Inputs: path, time, chNum, stimCh, chOfIntrst, stimulation, rmsT.

path : path to dat file- string 
Time : time of interests in minutes to be analyzed- vector sized 1 X 2  [start time  end time]
chNum : number of channels in the recording session (index 0 same as neuroscope)- sclar
chOfIntrst : channels of interests to be analyzed- scalar or vector (index 0)
Stimulation : channel number of the stimulation - scalar (index 0)
rmsT : an rms threshold : scalar with a sign (e.g -4)



Output: p, r, stimDur.


P : CDF value of getting that number of spike using a poisson distribution with lambda of
 r(1) X time of stimulation. (e.g P=1 more spike occurred during stimulation than baseline P=0  less spike occurred during stimulation than baseline).
1-P = the probability of getting this amount spike by chance.
P is a vector or a matrix, each row represents a channel and each column represents a stimulus intensity.
The first column is for the baseline so the P (:,1)=~0.5
r : spiking rate per sample r.*20000= average spiking rate of spike/sec
r is a vector or a matrix, each row represents a channel and each column represents a stimulus intensity.
The first column is for the baseline
stimDur :  the total samples for each stimuli and baseline 
So for all stimulation intensities (assuming theyhave the same time) stimDur(2)/stimDur(3)~=1
stimDur is a vector or a matrix, each row represents a channel and each column represents a stimulus intensity.
The first column is for the baseline

    
    Calls

   FindSpike, LoadData, R2P, SpikeResponse
 
If the current version of MATLAB  don't have  the function isalocalmin
One should use also 
myislocalmin and change in the  FindSpike function the use of islocalmean to myislocalmen 
Small function


LoadData

Input: path, time, chNum, chOfIntrest

path : path to dat file- string 
Time : time of interests in minutes to be analyzed- vector sized 1 X 2  [start time  end time]
chNum : number of channels in the recording session (index 0 same as neuroscope)- sclar
chOfIntrst : channels of interests to be analyzed- scalar or vector (index 0)

  Output: data: vector or a matrix as double variable from the dat file





FindSpike

Input: data,rmsT

Data: data as a double variable, (output for LoadData)
rmsT : an rms threshold : scalar with a sign (e.g -4)

Output:  spkI 

spkI:  indexes vector of the local minimums crossing rmsT

The function finds local minimums (using islocalmin or myloclmin)
That cross the rmsT.
The function removing one of two local min if they happen in an interval that is less the 20 samples








R2P


Input: raw, stimulation
raw : the raw stimulation signal as a vector (output of loadData)
Stimulation : channel number of the stimulation - scalar (index 0)

Output: Pstim, stimDur
Pstim: a vector of aprocced stimulation signal. for each sample the function gives a discrete integer between -1: number of stimulation intensity.
0 for all samples that are not recognize as stimulation
1 for all samples that are recognize as stimulation with the lowest intensity 
.
.
N for all samples that are recognize as stimulation with the N intensity
-1 for the 60 samples after the beginning and the end of the stimulation 
stimDur :  the total samples for each stimuli and baseline 
So for all stimulation intensities (assuming theyhave the same time) stimDur(2)/stimDur(3)~=1
stimDur is a vector or a matrix, each row represents a channel and each column represents a stimulus intensity.
The first column is for the baseline


SpikeResponse

Input: spkI,Pstim,stimDur

 spkI:  indexes vector of the local minimums crossing rmsT
Pstim: a vector of aprocced stimulation signal. for each sample the function gives a discrete integer between -1: number of stimulation intensity.
0 for all samples that are not recognize as stimulation
1 for all samples that are recognize as stimulation with the lowest intensity 
stimDur :  the total samples for each stimuli and baseline 
So for all stimulation intensities (assuming theyhave the same time) stimDur(2)/stimDur(3)~=1
stimDur is a vector or a matrix, each row represents a channel and each column represents a stimulus intensity.
The first column is for the baseline






Output: r
r :  r is the spiking rate per sample r.*20000= average spiking rate of spike/sec
r is a vector or a matrix, each row represents a channel and each column represents a stimulus intensity.
The first column is for the baseline
The function calculates how many events of spkI occurred during each state of Pstime (without -1 state see  R2P)
And divide it by the total number of sample for that state e.g stimDur


.





