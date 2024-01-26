Jan 26 2024; Xingge Xu

The code is for repreat the work published as..

For starting from raw data of lucullus output and MWF output to extract predictors and targets for MVDA
 trainning, run the following m.file in order

1. Lucullus_data_analysis.m
The code imports lucullus data and extracts predictors of OURdo, OURvol,base,CO2, deltaPH, capacitance, conductivity and all targets variables that been record with Lucucllus system.
Sepcific alignments were made depends on the condition of the data. All correction was denoted.
manually remove of outlier in OURvol before averaging is need for AdV03 and CG.
The lucullus file contains the time of sampling and should be carried to next step.

2. MWF_data_analysis.m
The code imports MWF data files and extracts predictors of  peak area (FL(A)) and peak intensity (FL(P)), and averages these varables within the same time frame as lucullus data.

3. dataforMVDA.m
This files organize the variables from previous two into sensor groups: FL,DE,PV and MS.
One should to able to see the values of each prdictors and targets at sampling time as same as in the ProcessedVariable.xlsx.

4. MVDA_nCV.m
This code run MVDA with a nested cross-validation, outer loop with leave one batch out, innerloop:leave one out
Three functions involved:
MVDAfit.m:to train the nested corss validation models of each target. Four MVDA methods trained : ANN, PLS LR and GP. Jyperparameter searched with Bayesian optimization.
ResultnCV.m:calculate the R2, rmse, rrmse, and, cross validation result from outerloop of nCV.
Result30.m: applying the partitioned models on signals with 30min interval to evaluate the real-time monitoring performance.

 
One can change the code in Lucullus_data_analysis.m to calculate nCV result for virus titer(VT data included).
Due to the randomness during leave one out partition and Bayesian search, one may not end up with the excatly same number as published in the paper.