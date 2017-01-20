%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the MATLAB version of the REC-FSA algorithm, described in the
%paper "Feature Selection for Performance Characterization in Multi-hop 
%Wireless Sensor Networks", by Panousopoulou, A; Azkune M.; and Tsakalides, P., 
%published at Ad Hoc Networks, 49 , pp. 70 - 89, 2016, ISSN: 1570-8705
%
%FORTH-ICS, Signal Processing Lab, 2014.

%Contact address: Nancy Panousopoulou, apanouso@ics.forth.gr

% If you find any of this dataset useful for your research, please give
% credit in your publications where it is due, using the following
% reference:
%@article{Panousopoulou_2016b,
%title = {Feature Selection for Performance Characterization in Multi-hop Wireless Sensor Networks},
%author = {Panousopoulou, Athanasia and Azkune, Mikel and Tsakalides, Panagiotis},
%issn = {1570-8705},
%year = {2016},
%date = {2016-06-21},
%journal = {Ad Hoc Networks},
%volume = {49},
%pages = {70 - 89}
%}

%
%  [repEn]=repent(data)
%  data is the feature matrix (NumInst x NumFeat) that we want to measure the representation
%  entropy
%  repEn is 2x1 size vector where the first is the absolute representation
%  entropy and the second is the normalized 
% 
%
%  Written by Mikel Azkune (2014, Forth Greece)
%

function [repEn]=repent(data)


clear repEn;
numFeat=size(data,2);

covMat=cov(data,1);%Create the covariance matrix of the features
eigenV=eig(covMat);%Take the Eigen Values
sumEigV=sum(eigenV);%Normalize the Eigen Values
for i=1:numFeat
    normLanda(i)=eigenV(i)/sumEigV;
end
Hr=0;
for i=1:numFeat %Calculate the entropy
    Hr=Hr-normLanda(i)*log10(normLanda(i));
end
HrN=Hr/log10(numFeat);%Noralize the Representation entropy
repEn=[Hr HrN];
