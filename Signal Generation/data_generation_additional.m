close all;
clear all;
addpath('D:\tfsa_5-5\windows\win64_bin');
n=0:63;


%SL_1=[0.25 0.25 0.35 -0.35 0  0   0  0.1 ];   
for k=1:1000

c=rand(1,8)-0.5;

IF1=c(1)+c(2)*(n/64)+c(3)*(n/64).^2;
IF2=c(4)+c(5)*(n/64)+c(6)*(n/64).^2;

s1=exp(2*pi*1i*filter(1,[1 -1],IF1));
s2=exp(2*pi*1i*filter(1,[1 -1],IF2));

%s1=exp(2*pi*1i*(0.05*n+0.0025*n.^2));
%s2=exp(2*pi*1i*(0.15*n+0.0025*n.^2));
c(7)=1;
c(8)=1;
x=c(7)*s1+c(8)*s2;

 [~, Wv] = wvd1(x);
 %figure;
 %tfsapl(x,Wv)
 Inew=zeros(64,64);
for nn=1:64
for kk=-1:1 
    Inew(mod(round(IF1(nn)*64*2)+kk,64)+1,nn)=(1/(2*abs(kk)+1))*c(7)^2;
    Inew(mod(round(IF2(nn)*64*2)+kk,64)+1,nn)=(1/(2*abs(kk)+1))*c(8)^2;
end
end
 %[~,II3]= post_processing_directional_data_gen(Wv,3,8,32);
 %figure;
 % tfsapl(x,Inew)
 I=quadtfd(x,length(x)-1,1,'specx',31,'hamm',length(x));
I1=quadtfd(x,length(x)-1,1,'specx',17,'hamm',length(x));
I2=quadtfd(x,length(x)-1,1,'specx',11,'hamm',length(x));
%I3=quadtfd(x,length(x)-1,1,'specx',41,'hamm',length(x));

Output(:,:,1,k)=Inew/max(abs(Inew(:)));
Input(:,:,1,k)=Wv/max(abs(Wv(:)));
%Input(:,:,2,k)=abs(Wv)/max(abs(Wv(:)));

%Input(:,:,:,k)=II3;

% Input(:,:,2,k)=abs(I)/max(abs(I(:)));
% Input(:,:,3,k)=abs(I1)/max(abs(I1(:)));
% Input(:,:,4,k)=abs(I2)/max(abs(I2(:)));

%Input(:,:,:,k)=II3/max(abs(II3(:)));

end

save('Set_large','Input','Output');