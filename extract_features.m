function [AllFeatsNorm,allFrequencyFeatsNorm,allTimeFeatsNorm,C1,C2,C3] = extract_features(dir1,dir2,dir3,extension,windowLength,stepLength)

TimeFeatsCrickets = [];
FreqFeatsCrickets = [];

TimeFeatsPig = [];
FreqFeatsPig = [];

TimeFeatsSipping = [];
FreqFeatsSipping = [];

filelistCrickets = dir(fullfile(dir1, extension));
filelistPig = dir(fullfile(dir2, extension));
filelistSipping =  dir(fullfile(dir3, extension));

for i=1:length(filelistCrickets)

    [y,fs] = audioread(filelistCrickets(i).name);

    %time domain
    [Energy, EEntropy, ZCR] = timedomainFeats(filelistCrickets(i).name, windowLength, stepLength);
    
    %frequency domain
    [Centroid, Spread, Entropy, Roll, Flux, mfccs] = freqFeatures(filelistCrickets(i).name, windowLength, stepLength);
    
    tmpF = [Centroid' Spread' Entropy' Roll' Flux' mfccs'];
    
    tmpT = [Energy' EEntropy' ZCR'];

    TimeFeatsCrickets = [TimeFeatsCrickets;tmpT];

    FreqFeatsCrickets = [FreqFeatsCrickets; tmpF];   
    
end

%Pig

for i=1:length(filelistPig)
    [y,fs] = audioread(filelistPig(i).name);

    %time domain
    [Energy, EEntropy, ZCR] = timedomainFeats(filelistPig(i).name, windowLength, stepLength);
    
    %frequency domain
    [Centroid, Spread, Entropy, Roll, Flux, mfccs] = freqFeatures(filelistPig(i).name, windowLength, stepLength);
    
    tmpF = [Centroid' Spread' Entropy' Roll' Flux' mfccs'];
    
    tmpT = [Energy' EEntropy' ZCR'];

    TimeFeatsPig = [TimeFeatsPig;tmpT];

    FreqFeatsPig = [FreqFeatsPig; tmpF];   
    
end

%Sipping

for i=1:length(filelistSipping)
    [y,fs] = audioread(filelistSipping(i).name);

    %time domain
    [Energy, EEntropy, ZCR] = timedomainFeats(filelistSipping(i).name, windowLength, stepLength);
    
    %frequency domain
    [Centroid, Spread, Entropy, Roll, Flux, mfccs] = freqFeatures(filelistSipping(i).name, windowLength, stepLength);
    
    tmpF = [Centroid' Spread' Entropy' Roll' Flux' mfccs'];
    
    tmpT = [Energy' EEntropy' ZCR'];

    TimeFeatsSipping = [TimeFeatsSipping;tmpT];

    FreqFeatsSipping = [FreqFeatsSipping; tmpF];   
    
end


% concatenate frequency features from all classes
allFrequencyFeats = [FreqFeatsCrickets; FreqFeatsPig; FreqFeatsSipping];

% concatenate time features from all classes
allTimeFeats = [TimeFeatsCrickets; TimeFeatsPig; TimeFeatsSipping];


%All Feats 

AllFeatsCrickets = [FreqFeatsCrickets TimeFeatsCrickets];
AllFeatsPig = [FreqFeatsPig TimeFeatsPig];
AllFeatsSipping = [FreqFeatsSipping TimeFeatsSipping];

AllFeats = [AllFeatsCrickets; AllFeatsPig ; AllFeatsSipping];
CricketsLabel = ones(1,length(AllFeatsCrickets));
PigLabel = repmat(2,1,length(AllFeatsPig));
SippingLabel = repmat(3,1,length(AllFeatsSipping));
label = [CricketsLabel PigLabel SippingLabel];

% normalize frequency

mn = mean(allFrequencyFeats);
st = std(allFrequencyFeats);
allFrequencyFeatsNorm =  (allFrequencyFeats - repmat(mn,size(allFrequencyFeats,1),1))./repmat(st,size(allFrequencyFeats,1),1);
allFrequencyFeatsNorm(isnan(allFrequencyFeatsNorm)) = 0;

% normalize time

mn = mean(allTimeFeats);
st = std(allTimeFeats);
allTimeFeatsNorm =  (allTimeFeats - repmat(mn,size(allTimeFeats,1),1))./repmat(st,size(allTimeFeats,1),1);

allTimeFeatsNorm(isnan(allTimeFeatsNorm)) = 0;

%Normalization All
mnT = mean(AllFeats);
stT = std(AllFeats);

AllFeatsNorm =  (AllFeats - repmat(mnT,size(AllFeats,1),1))./repmat(stT,size(AllFeats,1),1); 

AllFeatsNorm(isnan(AllFeatsNorm)) = 0;

C1=[repmat(1,length(TimeFeatsCrickets),1); repmat(2,length(TimeFeatsPig),1); repmat(3,length(TimeFeatsSipping),1)];

C2=[repmat(1,length(FreqFeatsCrickets),1); repmat(2,length(FreqFeatsPig),1); repmat(3,length(FreqFeatsSipping),1)];

C3=[repmat(1,length(AllFeatsCrickets),1); repmat(2,length(AllFeatsPig),1); repmat(3,length(AllFeatsSipping),1)];




