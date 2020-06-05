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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 I=HTFD_neww(Sig,3,5,64);
 I1=I;
 I1(I1<0.02*max(I1(:)))=0;
  I1=(I1/max(abs(I1(:))));
Ia1=I1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I=HTFD_neww(Sig,2,20,84);
 I1=I;
 I1(I1<0.02*max(I1(:)))=0;
 I1=(I1/max(abs(I1(:))));
 Ia2=I1;
%%%%%%%%%%%%%%%%%%%%%%%%%
I=HTFD_neww(Sig,3,6,54);
 I1=I;
 I1(I1<0.02*max(I1(:)))=0;
 I1=(I1/max(abs(I1(:))));
 Wv1=I1;

%%%%%%%%%%%%%%
Ia1=imresize(Ia1,[128 128]);
Ia2=imresize(Ia2,[128 128]);
Wv1=imresize(Wv1,[128 128]);
Wv=imresize(Wv,[128 128]);

yy(i,:,:,1)=Ia1/max(abs(Ia1(:)));
yy(i,:,:,2)=Ia2/max(abs(Ia2(:)));
yy(i,:,:,3)=Wv1/max(abs(Wv1(:)));

zz(i,:,:,1)=Wv/max(abs(Wv(:)));
zz(i,:,:,2)=Wv/max(abs(Wv(:)));
zz(i,:,:,3)=Wv/max(abs(Wv(:)));

end

save('adtfd_real_128','yy','zz');




