close all;
clear all;
addpath('G:\TFSA7\TFSA7');%
%load seizure;
N=128;
addpath('E:\tfsa_5-5\windows\win64_bin');
pathD='G:\d\pat006Iktal\';
filenameRoot={'010608ba_0011','010608ba_0023','010608ba_0030'};
maskStart=[	737530, 	757466, 	251198];
maskEnd=[     765163,      768589,      263806];
for f=3:3%length(filenameRoot)
             for i=3:3
            Ictal=importdata([pathD char(filenameRoot(f)) '_' num2str(i) '.asc']);
              end
 end
Ictal=interp(decimate(Ictal,2),1);
signal=Ictal(255198/2:257198/2)';
%  signal=Ictal(737530/2:765163/2)';
% signal=signal-mean(signal);
%                 signal=signal/norm(signal);
x=signal(200:200+127);
% x=awgn(x,0,'measured');
for i=1:2


[~, Wv] = wvd1(x);

 
[Ia1,~]= post_processing_directional(Wv,3,8,54);
[Ia2,~]= post_processing_directional(Wv,2,20,84);
Ia=min(Ia1,Ia2);
% [Ia1,~]= HTFD_neww(x,3,6,54);
% [Ia2,~]= HTFD_neww(x,2,20,74);
% Ia1=imresize(Ia1,[128 128]);
% Ia2=imresize(Ia2,[128 128]);
% Wv=imresize(Wv,[128 128]);

yy(i,:,:,1)=Ia1/max(abs(Ia1(:)));
yy(i,:,:,2)=Ia2/max(abs(Ia2(:)));
yy(i,:,:,3)=Wv/max(abs(Wv(:)));
figure;imagesc(Ia/max(abs(Ia(:))));
% figure;imagesc(Ia2/max(abs(Ia2(:))));

zz(i,:,:,1)=Wv/max(abs(Wv(:)));
zz(i,:,:,2)=Wv/max(abs(Wv(:)));
zz(i,:,:,3)=Wv/max(abs(Wv(:)));


end

save('adtfd_real_128','yy','zz');




