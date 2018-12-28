RM

FindSpikeTH 
MATLAB Function

The FindSpikeTH MATLAB function compares the number of spikes that occur during different stimulation intensities, with the number of spikes during baseline. The function then returns the P-value of getting these results by chance (the null hypothesis assumes that the stimulation does not affect the spiking rate).

The results of this function are based on three main assumptions:
SISO - single in single out;
Parameters set by the user only;
Detectable spikes.

SISO

The function assumes that there is only one stimulation source.
The function detects spikes for each channel without taking other recording sites into account.
Input only one stimulation signal into the function, and make sure that there are no other stimulations during that time. Otherwise, the function will not take the additional stimulation signals into account, preventing the baseline from being free of stimulation.

Parameters

Currently, the function assumes that the stimulation is a square pulse stimulation in different intensities.
That means that other types of stimulation (sine, ramp, and WN) will not result in an error, but will produce unreliable results.
It is also important to know, that the function is heavily dependant on the user’s input.
That means that there are no default parameters, and in cases when the user does not give one or more of the inputs, or if there is a mistake in one of the inputs, then the function will not work properly.
The function assumes that all stimulations’ intsenty are evenly applied (e.g., are equal in their total duration).

Spikes 

The function compares the number of spikes that occur at different times (stimulation and baseline). To do so, spikes must be detectable.
That means that the user should be able to recognise spikes, otherwise the results will be meaningless.


FindSpikeTH

Inputs: path, time, chNum, stimCh, chOfIntrst, stimulation, rmsT.

path: path to dat file - string. 
time: time of interest in minutes to be analyzed - vector size: 1X2  [start time, end time].
chNum: number of channels in the recording session (index 0 same as neuroscope) - sclar.
chOfIntrst: channels of interest to be analyzed - scalar or vector (index 0).
Stimulation: stimulation channel number - scalar (index 0).
rmsT: an rms threshold: scalar with a sign (e.g., -4).

Output: P, r, stimDur.

P: CDF value of getting that number of spike using a poisson distribution with lambda of
 r(1) X time of stimulation. (e.g P=1 more spikes occurred during stimulation than baseline; P=0  less spikes occurred during stimulation than baseline).
1-P = the probability of getting this result by chance.
P is a vector or a matrix, with each row representing a channel, and each column representing a stimulus intensity.
The first column represents the baseline, so that P (:,1)=~0.5
r: Spiking rate per sample. r.*20000= average spiking rate of spike/sec.
r is a vector or a matrix. In it, each row represents a channel and each column represents a stimulus intensity.
The first column represents the baseline.
stimDur: The total samples for each stimuli and baseline.
For all stimulation intensities (assuming they are of the same duration): stimDur(2)/stimDur(3)~=1
stimDur is a vector or a matrix, with each row representing a channel and each column representing a stimulus intensity.
The first column stands for the baseline.

Calls: FindSpike, LoadData, R2P, SpikeResponse.
 
If your current version of MATLAB doesn’t have the isalocalmin function, use 
myislocalmin instead, and change the use of islocalmean in the FindSpike function to myislocalmin.


Additional functions

LoadData

Input: path, time, chNum, chOfIntrest.

path: path to dat file - string .
time :time of interest in minutes to be analyzed - vector size: 1X2  [start time, end time].
chNum: number of channels in the recording session (index 0 same as neuroscope) - sclar.
chOfIntrst: channels of interest to be analyzed - scalar or vector (index 0).

Output: data: vector or a matrix as a double variable from the dat file.

FindSpike

Input: data, rmsT.

Data: data as a double variable (output for LoadData).
rmsT: an rms threshold: scalar with a sign (e.g., -4)..

Output: spkI 

spkI:  indexes vector of the local minimums crossing rmsT

The function finds local minimums (using islocalmin or myisloclmin) that cross the rmsT.
The function then removes one of the two local minimums, if they happen at an interval of less than 20 samples

R2P

Input: raw, stimulation.
raw: the raw stimulation signal as a vector (output of loadData).
Stimulation: the stimulation channel number - scalar (index 0).

Output: Pstim, stimDur.
Pstim: a vector of a processed stimulation signal. For each sample, the function gives a discrete integer between -1: number of stimulation intensity.
0 for samples that are not recognized as a stimulation.
1 for samples that are recognized as lowest intensity stimulation.
.
.
.
N for all samples that are recognized as stimulation with N intensity.
-1 for the 60 samples at the beginning the stimulation, and immediately at its end.
stimDur: the total samples for each stimuli and baseline.
For all stimulation intensities (assuming they are of the same duration): stimDur(2)/stimDur(3)~=1
stimDur is a vector or a matrix, with each row representing a channel and each column representing a stimulus intensity.
The first column represents the baseline.


SpikeResponse

Input: spkI,Pstim,stimDur.

spkI:  indexes vector of the local minimums crossing rmsT.
Pstim: a vector of a processed stimulation signal. For each sample, the function gives a discrete integer between -1: number of stimulation intensity.
0 for samples that are not recognized as a stimulation.
1 for samples that are recognized as lowest intensity stimulation.
.
.
.
N for all samples that are recognized as stimulation with N intensity.
-1 for the 60 samples at the beginning the stimulation, and immediately at its end.
stimDur:the total samples for each stimuli and baseline.
For all stimulation intensities (assuming they are of the same duration): stimDur(2)/stimDur(3)~=1
stimDur is a vector or a matrix, with each row representing a channel and each column representing a stimulus intensity.
The first column represents the baseline.

Output: r
r: Spiking rate per sample. r.*20000= average spiking rate of spike/sec.
r is a vector or a matrix. In it, each row represents a channel and each column represents a stimulus intensity.
The first column represents the baseline.

The function calculates the amount of spkI events that occur during each state of Pstime (without -1 state see R2P), and divide it by the total number of samples for that state, e.g. stimDur.
