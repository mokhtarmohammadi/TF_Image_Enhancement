close all;
clear all;
addpath('D:\tfsa_5-5\windows\win64_bin');
n=0:63;

%S_1=[0.05 0.15 0.05 0.45 0.2  0.3  0.1  0.3];   
sf_1=[0.14 0.06 0.16 0.3 0.08 0.33 0.2 0 0.2 0.01 0.4 0.4 0.05 0.05  0.45 0.3  0.05 0.2 0.3  0.05 0.05 0.2 0.1 0.45 0.25 0.3  0.2   0.3 0.35];
sf_2=[0.25 0.36 0.4 0.49 0.18 0.44  0.4 0.3 0.3 0.07 0.2 0.5 0.15 0.2  0.35 0.4 0.05 0.2 0.45 0.15 0.15 0.125 0.1 0.3 0.35 0.35  0.4 0.4 0.45];
c_1=[0.05 0.08 0.33 0 0 -0.1 0.05 0.3 0 0.4 0 -0.35 0.25 0.3 -0.25  0.35  0 0    0  0  0  0    0     -0.1 0  0.1  0  -0.15 0];
c_2=[0.35 -0.09 -0.33 0 0 -0.3 -0.05 -0.3 0 0.4 0 -0.35 0.25 0.3 -0.25 -0.35  0  0    0   0  0  0    0 -0.2 0 -0.1 0 -0.15 0];
d_1=[0 0 0 0.3 0.4 0 0 0 0.1 0 0 0 0  0 0 0 0 0   -0.1   0.1  0.3  0.1    0.2 -0.25 0.15 0 0 0 -0.25];
d_2=[0 0 0 -0.4 0.4 0 0 0 0.1 0 0 0 0  0 0  0 0 0   -0.1  0.3  0.3  -0.1    -0.2 -0.1 -0.15 0 0 0 -0.25];
a1=ones(size(c_1));
a2=ones(size(c_2));

c_1=[c_1 c_1 c_1];
c_2=[c_2 c_2 c_2];

d_1=[d_1 d_1 d_1];
d_2=[d_2 d_2 d_2];

sf_1=[sf_1 sf_1 sf_1];
sf_2=[sf_2 sf_2 sf_2];
    
a1=[a1 1.5*a1 a1];
a2=[a2 a2 1.5*a2];

% Sinusoidal FM signal
wf=[ 1 2 1 0.5 2 2.5];
mc=[0.15 0.2 0.3 0.4 0.15 0.15];
%SL_1=[0.25 0.25 0.35 -0.35 0  0   0  0.1 ];   
for k=1:length(sf_1)+length(wf)


if k>length(sf_1)
    
IF1=+0.3+mc(k-length(sf_1))*(sin(wf(k-length(sf_1))*2*pi*n/64));  
IF2=+0.3+0.15*(sin(2*pi*n/64));  

s1=exp(2*pi*1i*filter(1,[1 -1],IF1));
s2=0*n;
a1(k)=1;
a2(k)=0;
else
IF1=sf_1(k)+c_1(k)*(n/64)+d_1(k)*(n/64).^2;
IF2=sf_2(k)+c_2(k)*(n/64)+d_2(k)*(n/64).^2;
s1=exp(2*pi*1i*filter(1,[1 -1],IF1));
s2=exp(2*pi*1i*filter(1,[1 -1],IF2));
end


%s1=exp(2*pi*1i*(0.05*n+0.0025*n.^2));
%s2=exp(2*pi*1i*(0.15*n+0.0025*n.^2));
x=a1(k)*s1+a2(k)*s2;
 [~, Wv] = wvd1(x);
 %figure;
 %tfsapl(x,Wv)
 Inew=zeros(64,64);
for nn=1:64
for kk=-1:1 
    Inew(mod(round(IF1(nn)*64*2)+kk,64)+1,nn)=(1/(2*abs(kk)+1))*a1(k)^2;
    if a2(k)~=0
    Inew(mod(round(IF2(nn)*64*2)+kk,64)+1,nn)=(1/(2*abs(kk)+1))*a2(k)^2;
    end
end
end
 [I1,~]= post_processing_directional_low_res(Wv,3,8,24);
 [I2,~]= post_processing_directional_low_res(Wv,2,20,32);

 %figure;
 % tfsapl(x,Inew)
%  I=quadtfd(x,length(x)-1,1,'specx',31,'hamm',length(x));
% I1=quadtfd(x,length(x)-1,1,'specx',17,'hamm',length(x));
% I2=quadtfd(x,length(x)-1,1,'specx',9,'hamm',length(x));
%I3=quadtfd(x,length(x)-1,1,'specx',41,'hamm',length(x));

Output(:,:,1,k)=Inew/max(abs(Inew(:)));
Input(:,:,1,k)=I1/max(abs(I1(:)));
Input(:,:,2,k)=I2/max(abs(I2(:)));
Input(:,:,3,k)=Wv/max(abs(Wv(:)));


% Input(:,:,2,k)=abs(I)/max(abs(I(:)));
% Input(:,:,3,k)=abs(I1)/max(abs(I1(:)));
% Input(:,:,4,k)=abs(I2)/max(abs(I2(:)));

%Input(:,:,:,k)=II3/max(abs(II3(:)));

end

save('Set','Input','Output');