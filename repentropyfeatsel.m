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



%  function [ranking]=RepEntFS(origDataSet)
%  origDataSet is the original data set (NumInst x NumFeat)  
%  ranking is the list of the features ranked
%
%  The algorithm has been adopted from
%  RAIT-2012 , 1st Int'l Conf. on Recent Advances in Information Technology
%  "Unsupervised Feature Ranking based on Representation Entropy", by
%  Rao et al.
%  Written by Mikel Azkune (2014, Forth Greece)



function [ranking]=RepEntFS(origDataSet)
[numInst numFeat]=size(origDataSet);

HA=repent(origDataSet); %Measure the rep entropy of the complete data set
HI=[];
for i=1:numFeat % Measure the entropy of the data set removing the feature that is evaluating
    Data=origDataSet;
    Data(:,i)=[];
    mntH=repent(Data);
    HI=[HI, mntH(2)];
end
CE=HI-HA(2); % Calculate the CE to sort 
[Values Index]=sort(CE,'descend'); 
ranking=Index;
end

