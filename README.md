#Disclaimer

Copyright (c) 2011-2016, Signal Processing Lab (SPL), Institute of Computer Science (ICS), FORTH, Greece.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the Signal Processing Lab, the Institute of Computer Science and FORTH, nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THE SOFTWARE LIBRARIES AND DATASETS ARE PROVIDED BY THE INSTITUTE AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE INSTITUTE OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

-----------------------------------------------------------------

## Feature Selection for Performance Characterization in Multi-hop Wireless Sensor Networks
### The Representation Entropy Clustering - Feature Selection Algorithm (REC-FSA)


This is the MATLAB version of the REC-FSA algorithm, described in the paper "Feature Selection for Performance Characterization in Multi-hop Wireless Sensor Networks", by Panousopoulou, A; Azkune M.; and Tsakalides, P., published at Ad Hoc Networks, 49 , pp. 70 - 89, 2016, ISSN: 1570-8705. 

FORTH-ICS, Signal Processing Lab, 2014.

Contact address: Nancy Panousopoulou, apanouso@ics.forth.gr

## Directory contents
* mainrun_RECFSA.m: The main MATLAB script for loading the datasets, performing sanity checks and normalization on each dataset, calculating the dominant features based on the REC-FSA and storing the results to a mat file.
* RepEntFSalgCluster.m: The implementation of the REC-FSA.
* repent.m, repentropyfeatsel.m: Auxiliary scripts for the REC-FSA.

## Input Data Format
This code can accept multiple datasets, provided as csv files. Each csv file has NxM matrices, where N is the number of samples and M is the number of features. 

In the provided code, the sample data considered are network features, extracted from WSN measurements at an industrial environment during the period 05-06/06/2014.
The data are available at the datasets subfolder, where their format is also analytically described.



## How to run
1. download the directory 
2. open the mainrun_RECFSA.m and define the absolute path of the datasets at line 49 and the naming convention of each input dataset at line 57. The sample data used are stored at the "datasets/" folder, and contain 10 csv files with the following naming convention: 'node' <node number> '.csv'
3. the algorithm considers that the input attributes are not normalized. Define at line 50 the index of the features that are already normalized within [0,1]. 
4. Save and run mainrun_RECFSA.m through MATLAB environment.



## How to cite this work
If you find any of this dataset useful for your research, please give
credit in your publications where it is due, using the following
reference:

@article{Panousopoulou_2016b,
title = {Feature Selection for Performance Characterization in Multi-hop Wireless Sensor Networks},
author = {Panousopoulou, Athanasia and Azkune, Mikel and Tsakalides, Panagiotis},
issn = {1570-8705},
year = {2016},
date = {2016-06-21},
journal = {Ad Hoc Networks},
volume = {49},
pages = {70 - 89}
}



##References
1. V. M. Rao and V. N. Sastry, "Unsupervised feature ranking based on representation entropy," 2012 1st International Conference on Recent Advances in Information Technology (RAIT), Dhanbad, 2012, pp. 421-425.
doi: 10.1109/RAIT.2012.6194631



