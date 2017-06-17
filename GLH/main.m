close all;
clc;
clear;

load(['dataset/','Ls']);

ns = 9; %subspace的维度

k = 3;
L = 20;
d = 1024;
%m = 38; %query的个数
n = 38; %数据库中人脸数目

H = setup_lsh(Ls, ns, k, L, d);

%generate query subspace
load ('query9.mat');

[hashresult, mindq, evals] = simple_search(H, query);%hash后的检索结果

%[directresult, dq, evals] = exact_search(H, query);%直接搜索结果