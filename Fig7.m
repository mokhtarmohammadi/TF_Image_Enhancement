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
SampFreq = 32;
t = 0:1/SampFreq:1-1/SampFreq;
f = linspace(0,SampFreq/2,128);
i=2;
load resultRealSingle;
%%%%%%%%%%%%%%%% ADTFD(2,30,16) %%%%%%%%%%%
% modelfile = 'model_train.h5';
% net = importKerasNetwork(modelfile)
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Single view %%%%%%%%%%%%%%%%%%%%%%
TF(:,:)=squeeze(yy(i,:,:,1));
%TF(TF<0.2*max(TF(:)))=0;
figure;
imagesc(t,f,squeeze(yy(i,:,:,1))); 
% axis([0 1 -SampFreq/2 SampFreq/2]);
set(gcf,'Position',[20 100 640 500]);	    
xlabel('Time / Sec','FontSize',20,'FontName','Times New Roman');
ylabel('Frequency / Hz','FontSize',20,'FontName','Times New Roman');
set(gca,'YDir','normal');
title('(a)','FontSize',24,'FontName','Times New Roman');
set(gca,'FontSize',20);
colorbar;
print -dpng -r600 Fig6a
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TF_f1m=sum(sum(abs( squeeze(yy(i,:,:))).^0.5)) /sum(sum(squeeze(yy(i,:,:))))
TF_f1s=(sum(sum(abs( squeeze(yy(i,:,:))).^0.5)))^2/sum(sum(squeeze(yy(i,:,:))))
%%%%%%%%%%%%%%%%%%%%%%%%%%% Multiple view CNN %%%%%%%%%%%%%%%%
load resultRealMultiple;

TF(:,:)=squeeze(yy(i,:,:,1));
%TF(TF<0.3*max(TF(:)))=0;
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
print -dpng -r600 Fig6b

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LO-ADTFD %%%%%%%%%%%%%%%%%%%
load adtfd_real_128;
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
print -dpng -r600 Fig6c

