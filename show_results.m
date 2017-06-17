function show_results(dataset,h)

%%
if nargin < 2
    h = 1;
end
j = h+1;  % hamming ball radius <= h

%% Load Experimental Results
alg_list = {'CBH'}; %'BHZ','GLH'
alg_num = length(alg_list);
trueP_list = cell([1,alg_num]);
trueR_list = cell([1,alg_num]);
%trueF1_list = cell([1,alg_num]);
cateP_list = cell([1,alg_num]);
cateR_list = cell([1,alg_num]);
%cateF1_list = cell([1,alg_num]);
cateA_list = cell([1,alg_num]);
for g = 1:alg_num
    load(['results/',dataset,'_',alg_list{g}]);
    trueP_list{g} = trueP;
    trueR_list{g} = trueR;
    %trueF1_list{g} = trueF1;
    clear trueP trueR trueF1;
    %cateP_list{g} = cateP;
    %cateR_list{g} = cateR;
    %cateF1_list{g} = cateF1;
    clear cateP cateR cateF1;
    cateA_list{g} = cateA;
    clear cateA;
end

%%
colours = 'bgrkk';  % 'bgrcmykw'
symbols = 'x+^os';  % '.ox+*sdv^<>ph'
linetypes = {'-','-','-','-','-'};  % {'-',':','-.','--'}

%%
alg_list = {'CBH'}; %'BHZ','GLH'
alg_num = length(alg_list);

%% true F1 measure
% figure;
% for g = 1:alg_num
%     plot(codeLen, trueF1_list{g}(:,j), [colours(g),symbols(g),char(linetypes(g))]); 
%     hold on;
% end
% xlabel('code length');
% ylabel('F_1 measure');
% axis([codeLen(1) codeLen(m) 0 1]);
% legend(alg_list, 'location', 'NorthEast');

%% true Precision-Recall curve
figure; 
for g = 1:alg_num
    plot(trueR_list{g}(:,j), trueP_list{g}(:,j), [colours(g),symbols(g),char(linetypes(g))]);
    hold on;
end
xlabel('recall');
ylabel('precision');
axis([0 1 0 1]);
legend(alg_list, 'location', 'NorthEast');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25,2.5,4,3]);
saveas(gcf,['fig/truePR_',dataset,'.eps'],'epsc');

%%
alg_list = {'CBH'}; %'BHZ','GLH'
alg_num = length(alg_list);

% %% cate F1 measure
% figure;
% for g = 1:alg_num
%     plot(codeLen, cateF1_list{g}(:,j), [colours(g),symbols(g),char(linetypes(g))]); 
%     hold on;
% end
% xlabel('code length');
% ylabel('F_1 measure');
% axis([codeLen(1) codeLen(m) 0 1]);
% legend(alg_list, 'location', 'NorthEast');

%% cate Precision-Recall curve
figure; 
for g = 1:alg_num
    plot(cateR_list{g}(:,j), cateP_list{g}(:,j), [colours(g),symbols(g),char(linetypes(g))]);
    hold on;
end
xlabel('recall');
ylabel('precision');
axis([0 1 0 1]);
legend(alg_list, 'location', 'NorthEast');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25,2.5,4,3]);
saveas(gcf,['fig/catePR_',dataset,'.eps'],'epsc');

%% cate Accuracy
figure;
for g = 1:alg_num
    plot(codeLen, cateA_list{g}(:,j), [colours(g),symbols(g),char(linetypes(g))]); 
    hold on;
end
xlabel('code length');
ylabel('accuracy');
axis([codeLen(1) codeLen(m) 0 1]);
legend(alg_list, 'location', 'NorthEast');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25,2.5,4,3]);
saveas(gcf,['fig/cateA_',dataset,'.eps'],'epsc');

end
