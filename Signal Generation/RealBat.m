close all;
clear all;
addpath('G:\TFSA7\TFSA7');%
SampFreq = 1;
t=1:400;

delta=4;
addpath('E:\tfsa_5-5\windows\win64_bin');
%addpath('D:\TFSA7\TFSA7');%


Sig=bat_signal();
 %Sig=decimate(Sig,4);
%Sig=filter([1 -1],1,Sig);
% 
  n=0:length(Sig)-1;
%   Sig=Sig.'+0.075*cos(2*pi*(0.1*n+2*0.00012*n.^2)).*gausswin(400).';
f = linspace(0,SampFreq/2,length(Sig));
%Sig=awgn(Sig,5,'measured');
Sig=Sig';
for i=1:2


[~, Wv] = wvd1(Sig);

 I=HTFD_neww(Sig,3,5,64);
 TF1=I;
TF1(TF1<0.02*max(TF1(:)))=0;

 I1=I;
 I1(I1<0.02*max(I1(:)))=0;
  I1=(I1/max(abs(I1(:))));

I1(abs(I1)>0)=abs(sqrt(sqrt(abs(I1(abs(I1)>0))))).*sign(I1(abs(I1)>0));
 % I1=log(abs(I1));
%I1(I1<0)=I1(I1<0)-min(I1(:));
Ia1=I1;
%  imagesc(I1);
I=HTFD_neww(Sig,2,20,84);
TF2=I;
TF2(TF2<0.02*max(TF2(:)))=0;
 I1=I;
 I1(I1<0.02*max(I1(:)))=0;
  I1=(I1/max(abs(I1(:))));

I1(abs(I1)>0)=abs(sqrt(sqrt(abs(I1(abs(I1)>0))))).*sign(I1(abs(I1)>0));
 % I1=log(abs(I1));
%I1(I1<0)=I1(I1<0)-min(I1(:));
Ia2=I1;
% figure;imagesc(I1);

% [Ia1,~]= post_processing_directional(Wv,3,12,64);
% [Ia2,~]= post_processing_directional(Wv,3,12,128);
% [Ia1,~]= HTFD_neww(Sig,3,6,64);
% [Ia2,~]= HTFD_neww(Sig,2,30,128);

% Ia1(abs(Ia1)>0)=log(Ia1(abs(Ia1)>0)).*log(Ia1(abs(Ia1)>0));
% Ia2(abs(Ia2)>0)=log(Ia2(abs(Ia2)>0)).*log(Ia2(abs(Ia2)>0));
% Wv(abs(Wv)>0)=log(Wv(abs(Wv)>0)).*log(Wv(abs(Wv)>0));

% Ia1=sign(Ia1);
% Ia2=sign(Ia2);
% Wv=sign(Wv);


Ia1=imresize(Ia1,[128 128]);
Ia2=imresize(Ia2,[128 128]);
Wv=imresize(Wv,[128 128]);

% Ia1=log(Ia1)*sign(Ia1);
% Ia2=log(Ia2)*sign(Ia2);
% Wv1=log(Wv1)*sign(Wv1);
yy(i,:,:,1)=Ia1/max(abs(Ia1(:)));
yy(i,:,:,2)=Ia2/max(abs(Ia2(:)));
yy(i,:,:,3)=Wv/max(abs(Wv(:)));
% figure;imagesc(Ia1/max(abs(Ia1(:))));
% figure;imagesc(Ia2/max(abs(Ia2(:))));

zz(i,:,:,1)=Wv/max(abs(Wv(:)));
zz(i,:,:,2)=Wv/max(abs(Wv(:)));
zz(i,:,:,3)=Wv/max(abs(Wv(:)));

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
print -dpng -r600 Fig7c
end

save('adtfd_real_128','yy','zz');




