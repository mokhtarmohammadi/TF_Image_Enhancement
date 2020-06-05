close all;
clear all;

%load net_wvd;
N=128;


n=0:N-1;
% % % Parallel Example B
 a1=1;
a2=1;
a3=1;
for i=1:5
    
    switch i
        case 1
    IF1=0.05+0*0.1*(n/64)+1*0.35*(n/N).^2;
        IF2=0.1+0*0.25*(n/64)+1*0.35*(n/N).^2;
IF3=0.475+0*0.25*(n/64)-1*0.05*(n/N).^2;
        case 2

IF1=0.35+0*0.1*(n/64)-1*0.35*(n/N).^2;
IF2=0.4+0*0.25*(n/64)-1*0.35*(n/N).^2;
IF3=0.45+0*0.25*(n/64)-1*0.02*(n/N).^2;
%
        case 3 
% % % INtersecting Example A
IF1=0.05+0*0.25*(n/N)+1*0.3*(n/N).^2;
IF2=0.35-0*0.25*(n/N)-1*0.3*(n/N).^2;
 IF3=0.2+1*0.2*(n/N)-0*0.2*(n/N).^2;
% % % % % %
% % % % % %
% %
        case 4
% % % % INtersecting Example A
IF1=0.05+0*0.25*(n/N)+1*0.45*(n/N).^2;
IF2=0.3-0*0.25*(n/N)-1*0.3*(n/N).^2;
IF3=0.48+0*0.25*(n/N)-0.4*(n/N).^2;
 
        case 5 
 IF1=+0.3+0.15*(sin(2*pi*n/N));
 IF2=0.04+0*n;
 IF3=zeros(1,N);

    a3=0;
      case 6 
 IF1=+0.3+0.15*(sin(2*pi*n/N));
 IF2=0.04+1*n;
 IF3=zeros(1,N);

    a3=0;
    end
    s1=exp(2*pi*1i*filter(1,[1 -1],IF1));
s2=exp(2*pi*1i*filter(1,[1 -1],IF2));
s3=exp(2*pi*1i*filter(1,[1 -1],IF3));

x=a1*s1+a2*s2+a3*s3;
%x=a1*s1+a2*s2;
%x=awgn(x,0,'measured');

[~, Wv] = wvd1(x);

 
[Ia1,~]= post_processing_directional(Wv,3,6,54);
[Ia2,~]= post_processing_directional(Wv,2,20,84);
%[Ia3,~]= post_processing_directional(Wv,2,6,54);


yy(i,:,:,1)=Ia1/max(abs(Ia1(:)));
yy(i,:,:,2)=Ia2/max(abs(Ia2(:)));
%yy(i,:,:,3)=Ia3/max(abs(Ia3(:)));
yy(i,:,:,3)=Wv/max(abs(Wv(:)));

zz(i,:,:,1)=Wv/max(abs(Wv(:)));
zz(i,:,:,2)=Wv/max(abs(Wv(:)));
zz(i,:,:,3)=Wv/max(abs(Wv(:)));

end




save('adtfd_test_128','yy','zz');




