%  
%%  Author:
%     Mokhtar Mohammadi
%In this code we assume that the user add in this path the TFSAP toolboox.
%% Locating and Adding Functions Directory
clear all;
currentDirectory = pwd;
[upperPath, ~, ~] = fileparts(currentDirectory);
addpath([upperPath '/Core'])
addpath([upperPath '/TFSA5'])
addpath(['/Users/macbookpro/Desktop/untitled folder/Source1/TFSA5/win64_bin'])
SampFreq = 128;
t = 0:1/SampFreq:1-1/SampFreq;
f = linspace(0,SampFreq/2,128);
i=3;
load result_single;
%%%%%%%%%%%%%%%% ADTFD(2,30,16) %%%%%%%%%%%
% modelfile = 'model_train.h5';
% net = importKerasNetwork(modelfile)
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Single view %%%%%%%%%%%%%%%%%%%%%%
TF(:,:)=squeeze(zz(i,:,:,1));
figure;
imagesc(t,f,TF); 
% axis([0 1 -SampFreq/2 SampFreq/2]);
set(gcf,'Position',[20 100 640 500]);	    
xlabel('Time / Sec','FontSize',20,'FontName','Times New Roman');
ylabel('Frequency / Hz','FontSize',20,'FontName','Times New Roman');
set(gca,'YDir','normal');
title('(a)','FontSize',24,'FontName','Times New Roman');
set(gca,'FontSize',20);
colorbar;
%print -dpng -r600 figures/Single_View
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TF_f1m=sum(sum(abs( squeeze(zz(i,:,:))).^0.5)) /sum(sum(squeeze(zz(i,:,:))))
TF_f1s=(sum(sum(abs( squeeze(zz(i,:,:))).^0.5)))^2/sum(sum(squeeze(zz(i,:,:))))
%%%%%%%%%%%%%%%%%%%%%%%%%%% Multiple view CNN %%%%%%%%%%%%%%%%
load result_multiple;
TF(:,:)=squeeze(yy(i,:,:,1));
figure;
imagesc(t,f,TF); 
% axis([0 1 -SampFreq/2 SampFreq/2]);
set(gcf,'Position',[20 100 640 500]);	    
xlabel('Time / Sec','FontSize',20,'FontName','Times New Roman');
ylabel('Frequency / Hz','FontSize',20,'FontName','Times New Roman');
set(gca,'YDir','normal');
title('(b)','FontSize',24,'FontName','Times New Roman');
set(gca,'FontSize',20);
colorbar;
TF_f2m=sum(sum(abs( TF).^0.5)) /sum(sum(TF))
TF_f2s=(sum(sum(abs( TF).^0.5)))^2/sum(sum(TF))
%print -dpng -r600 figures/Multiple_View

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LO-ADTFD %%%%%%%%%%%%%%%%%%%
load adtfd_test_128;
TF1(:,:)=squeeze(yy(i,:,:,1));
TF2(:,:)=squeeze(yy(i,:,:,2));
TF=min(TF1,TF2);
figure;
imagesc(t,f,TF); 
% axis([0 1 -SampFreq/2 SampFreq/2]);
set(gcf,'Position',[20 100 640 500]);	    
xlabel('Time / Sec','FontSize',20,'FontName','Times New Roman');
ylabel('Frequency / Hz','FontSize',20,'FontName','Times New Roman');
set(gca,'YDir','normal');
title('(c)','FontSize',24,'FontName','Times New Roman');
set(gca,'FontSize',20);
colorbar;
TF_f3m=sum(sum(abs( TF).^0.5)) /sum(sum(TF))
TF_f3s=(sum(sum(abs( TF).^0.5)))^2/sum(sum(TF))
%print -dpng -r600 figures/ADTFD

