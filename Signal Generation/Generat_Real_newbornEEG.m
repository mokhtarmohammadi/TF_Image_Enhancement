close all;
clear all;
addpath('G:\TFSA7\TFSA7');%
load seizure;
N=256;
Sig=sez_dat(150,:);
%Sig=filter([1 -1],1,Sig);
% [b,a] = butter(5,2/32,'high'); 
% Sig = filtfilt( b,a,Sig);

n=1:128;
x=Sig;
x=decimate(Sig,2);
%  x=awgn(x,5,'measured');
SampFreq = 32;
t = 0:1/SampFreq:1-1/SampFreq;
f = linspace(0,SampFreq/2,256);

for i=1:2


[~, Wv] = wvd1(x);
Wv1=Wv;
%[Ia1,~]= post_processing_directional(Wv,3,5,44);
% [Ia2,~]= post_processing_directional(Wv,2,6,54);
[Ia1,~]= HTFD_neww(x,2,15,54);
[Ia2,~]= HTFD_neww(x,3,6,64);

% Ia1(Ia1<0.01*max(Ia1(:)))=0;
% Ia2(Ia2<0.01*max(Ia2(:)))=0;
 %Wv(Wv<0.01*max(Wv(:)))=0;

% Ia1(abs(Ia1)>0)=log(Ia1(abs(Ia1)>0)).*sign(Ia1(abs(Ia1)>0));
% Ia2(abs(Ia2)>0)=log(Ia2(abs(Ia2)>0)).*sign(Ia2(abs(Ia2)>0));
% Wv(abs(Wv)>0)=log(Wv(abs(Wv)>0)).*log(Wv(abs(Wv)>0));

Ia1=Ia1/max(abs(Ia1(:)));
Ia2=Ia2/max(abs(Ia2(:)));
Wv=Wv/max(abs(Wv(:)));
Wv1=Wv1/max(abs(Wv1(:)));

Ia1=imresize(((Ia1)),[128 128]);
Ia2=imresize(((Ia2)),[128 128]);
Wv=imresize(((Wv)),[128 128]);
Wv1=imresize(((Wv1)),[128 128]);

yy(i,:,:,1)=Ia1;%/max(abs(Ia1(:)));
yy(i,:,:,2)=Ia2;%/max(abs(Ia2(:)));
yy(i,:,:,3)=Wv;%/max(abs(Wv(:)));
Ia=min(Ia1,Ia2);
if i==1 
    test=Ia1;
else
    test=Ia2;
end
figure;
imagesc(t,f,test); 
% % axis([0 1 -SampFreq/2 SampFreq/2]);
% set(gcf,'Position',[20 100 640 500]);	    
% xlabel('Time / Sec','FontSize',20,'FontName','Times New Roman');
% ylabel('Frequency / Hz','FontSize',20,'FontName','Times New Roman');
% set(gca,'YDir','normal');
% title('(c)','FontSize',24,'FontName','Times New Roman');
% set(gca,'FontSize',20);
% colorbar;
% TF_f3m=sum(sum(abs( Ia).^0.5)) /sum(sum(Ia))
% TF_f3s=(sum(sum(abs( Ia).^0.5)))^2/sum(sum(Ia))
% print -dpng -r600 Fig6c

zz(i,:,:,1)=Wv1/max(abs(Wv1(:)));
zz(i,:,:,2)=Wv1/max(abs(Wv1(:)));
zz(i,:,:,3)=Wv1/max(abs(Wv1(:)));


end

save('adtfd_real_128','yy','zz');




