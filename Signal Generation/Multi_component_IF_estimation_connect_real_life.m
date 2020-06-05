clc
clear all;
%close all
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
  Sig=Sig.'+0.075*cos(2*pi*(0.1*n+2*0.00012*n.^2)).*gausswin(400).';
f = linspace(0,SampFreq/2,length(Sig));

  %   Sig=hilbert(Sig);
% t=0:1/16:8-1/16;
%[tfd,orient]=HTFD_new_dec(Sig,3,15,64,4);
%[tfd1,orient]=HTFD_neww(Sig,3,12,64);
[tfd,orient]=HTFD_neww(Sig,3,12,128);
%[tfd,orient]=HTFD_neww(Sig,2,40,64*2);
%tfd=min(tfd,tfd1);
%tfsapl(Sig,tfd);

%tfd=min(tfd,tfd1);
tfd(1:5,:)=0;
figure;imagesc(t,f,tfd); 
% figure;imshow(1-tfd,[]);
set(gcf,'Position',[20 100 640 500]);	    
xlabel('Time / Sec','FontSize',20,'FontName','Times New Roman');
ylabel('Frequency / Hz','FontSize',20,'FontName','Times New Roman');
set(gca,'YDir','normal');
title('(a)','FontSize',24,'FontName','Times New Roman');
set(gca,'FontSize',20);

[IF,out, peaks] = component_linking_neww(tfd,orient,0.005,length(Sig)/8,40,20);
%[IF,out, peaks] = component_linking_neww_direc(tfd,orient,0.01,length(Sig)/4,30,15);

%figure;tfsapl(Sig,peaks)
%figure; tfsapl(Sig,out.*tfd)

IF_est=fill_zeros(IF);
% plot(IF_est.');
% axis([0 1 0 64]);

[a,b]=size(IF_est);
IF_image=zeros(size(out));
IF_est=round(IF_est);
for ii=1:a
    for jj=1:b
        if IF_est(ii,jj)~=0
        IF_image(IF_est(ii,jj),jj)=1;
        end
    end
end

%tfsapl(Sig,IF_image.*tfd)
figure;% plot(IF_est.')
plot(IF_est.'/2,'linewidth',2);
xlabel('Time / Sec','FontSize',24,'FontName','Times New Roman');
ylabel('Frequency / Hz','FontSize',24,'FontName','Times New Roman');
title('(b)','FontSize',24,'FontName','Times New Roman');
set(gca,'FontSize',20)
set(gca,'linewidth',2);

figure;imagesc(t,f,peaks);
% figure;imshow(1-peaks,[]);
set(gcf,'Position',[20 100 640 500]);	    
xlabel('Time / Sec','FontSize',20,'FontName','Times New Roman');
ylabel('Frequency / Hz','FontSize',20,'FontName','Times New Roman');
set(gca,'YDir','normal');
title('(c)','FontSize',24,'FontName','Times New Roman');
set(gca,'FontSize',20);

figure;imagesc(t,f,IF_image);
% figure;imshow(1-IF_image,[]);
set(gcf,'Position',[20 100 640 500]);	    
xlabel('Time / Sec','FontSize',20,'FontName','Times New Roman');
ylabel('Frequency / Hz','FontSize',20,'FontName','Times New Roman');
set(gca,'YDir','normal');
title('(d)','FontSize',24,'FontName','Times New Roman');
set(gca,'FontSize',20);

%axis([0 8 0 8]); 
 %xlabel('Time(s)');
 %ylabel('Instantaneous Frequency (Hz)');
% Sig=awgn(Sig,14,'measured');


% [tfd1,orient1]=HTFD_neww(Sig,2,20,length(Sig)/2);
% [tfd2,orient2]=HTFD_neww(Sig,2,50,length(Sig)/2);
% tfd=min(tfd1,tfd2);
% 
% for ii=1:length(tfd1)
%     for jj=1:length(tfd2)
%             value=min(tfd1(ii,jj),tfd2(ii,jj));
%             tfd(ii,jj)=value;
%             if tfd1(ii,jj)==value
%             orient(ii,jj)=orient1(ii,jj);
%             else
%             orient(ii,jj)=orient2(ii,jj);
% 
%             end
%             
%          
%     end
% end
%


%[IF,out, peaks] = component_linking(tfd,0.1,64);
 %figure; imagesc(out)
 %IF_est=fill_zeros(IF);
 %figure; plot(IF_est.')
