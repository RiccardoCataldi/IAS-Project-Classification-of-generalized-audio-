clear; clc
addpath(genpath(pwd))
windowLength = 0.03;
stepLength = 0.01;

trainCricketsPath = [pwd,'/Crickets/train/'];
trainPigPath = [pwd,'/Pig/train/'];
trainSippingPath = [pwd,'/sipping/train/'];

testCricketsPath = [pwd,'/Crickets/test/'];
testPigPath = [pwd,'/Pig/test/'];
testSippingPath = [pwd,'/sipping/test/'];

%train

[allFeatstrain,allFreqtrain,allTimetrain,trainlabeltime, trainlabelfrequency,trainlabelalltogether] = extract_features(trainCricketsPath, trainPigPath, trainSippingPath,'*.ogg',windowLength,stepLength);

%test 

[allFeatstest, allFreqtest, allTimeTest,testlabeltime, testlabelfrequency,testlabelalltogether] = extract_features(testCricketsPath,testPigPath,testSippingPath,'*.ogg',windowLength,stepLength);

allFeats = [allFeatstrain; allFeatstest];

AllLabels = [trainlabelalltogether ;testlabelalltogether];

num_coeffs = pca_visualization(allFeats,AllLabels)


k=[1 5 10 15 20 50 100];  
disp('knn per le time domain features') 

[predLTime,rateTime]=kNN(k,allTimetrain, trainlabeltime, allTimeTest, testlabeltime,1); 

disp('knn per le frequency domain features') 
disp('') 
[ predLFrequency,rateFrequency]=kNN(k,allFreqtrain , trainlabelfrequency, allFreqtest, testlabelfrequency,2); 

disp('kNN per tutte le features') 
disp('') 
[predLAll,rateAll]=kNN(k, allFeatstrain, trainlabelalltogether, allFeatstest, testlabelalltogether,3); 

figure
plot_kNN(3,1,1,k,rateTime,'KnnTime')
plot_kNN(3,1,2,k,rateFrequency,'KnnFreq')
plot_kNN(3,1,3,k,rateAll,'KnnAll')

figure
window_sizes = [0.03 0.05 0.1 0.5];
k = [1 5 10 15 20 50 100];
plot_kNN(2,2,1,k,rateTime,'0.03')
knnWin(k,trainCricketsPath, trainPigPath, trainSippingPath,testCricketsPath,testPigPath,testSippingPath,'*.ogg',stepLength,window_sizes)
sgtitle('KNN Optimized');


