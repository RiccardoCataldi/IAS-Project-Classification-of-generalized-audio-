function [] = knnWin(k,dir1,dir2,dir3,dir4,dir5,dir6,extension,stepLength,window_sizes)
%train


for l=2:length(window_sizes)
    [allFeatstrain,allFreqtrain,allTimetrain,trainlabeltime, trainlabelfrequency,trainlabelalltogether] = extract_features(dir1, dir2, dir3,'*.ogg',window_sizes(l),stepLength);

%test 

    [allFeatstest, allFreqtest, allTimeTest,testlabeltime, testlabelfrequency,testlabelalltogether] = extract_features(dir4,dir5,dir6,'*.ogg',window_sizes(l),stepLength);

    %allFeats = [allTimetrain; allTimeTest];

    %AllLabels = [trainlabeltime ;testlabeltime];

    disp('knn per le time domain features') 

    [figure,rateTime]=kNN(k,allTimetrain, trainlabeltime, allTimeTest, testlabeltime,1); 
    
    plot_kNN(2,2,l,k,rateTime,mat2str(window_sizes(l)))

end