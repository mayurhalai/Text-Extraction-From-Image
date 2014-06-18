clear all;
close all;
clc;
FileName = uigetfile('*');
im = imread(FileName);
% dpi = 180;
% im = imresize(im,300/dpi);
TH = binarize(im);
th = skew(TH);
th = im2bw(th,0.5);
CC = bwconncomp(th);
m1 = CC.NumObjects;
rn = CC.ImageSize(1);
enough = CC.PixelIdxList;
boxmat = zeros(m1,5);
for i = 1:m1
    temp = enough{1,i};
    temp1 = mod(temp,rn*ones(size(temp)));
    temp2 = ceil(temp./rn);
    boxmat(i,1) = min(temp1);
    boxmat(i,2) = min(temp2);
    boxmat(i,3) = max(temp1);
    boxmat(i,4) = max(temp2);
    boxmat(i,5) = (boxmat(i,3)-boxmat(i,1))*(boxmat(i,4)-boxmat(i,2));
end

ind = mean(boxmat(:,5))/8;
for i = 1:m1
    if boxmat(i,5) < ind
        th(enough{1,i}) = 0;
        boxmat(i,:) = 0;
    end
end

boxmat = sortrows(boxmat,1);
sb=size(boxmat,1);
i = 1;
while boxmat(i,1)==0 && i<sb
    i = i+1;
end
boxmat = boxmat(i:m1,:);
boxfinal = sortcol(boxmat);
m2 = size(boxfinal,1);

testmat = zeros(m2,1024);
p3=zeros(m2,2);
for i = 1:m2
temp = th(boxfinal(i,1):boxfinal(i,3),boxfinal(i,2):boxfinal(i,4));
p3(i,1)=boxfinal(i,3)-boxfinal(i,1);
p3(i,2)=boxfinal(i,4)-boxfinal(i,2);
temp = fvect(temp);
testmat(i,:) = temp;
end

p = predictnn(testmat);

p1 = zeros(m2,1);
for i = 1:m2-1
    p1(i) = boxfinal(i+1,2)-boxfinal(i,4);
end
m3 = find(p1>0);
ind2 = mean(p1(m3));
p2 = zeros(m2,1);
ind21 = ind2*1.5;
ind22 = ind2*(-10);
for i = 1:m2
    if p1(i)>ind21
        p2(i) = 1;
    end
    if p1(i) < ind22
        p2(i) = 2;
    end
end

p = [p p2 p3];

x=zeros(size(p,1),1);
for i=1:size(p,1)
x(i,1)=p(i,4)/p(i,3);
end

p = [p x];

key = ['0';'1';'2';'3';'4';'5';'6';'7';'8';'9';'A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z';'a';'b';'c';'d';'e';'f';'g';'h';'i';'j';'k';'l';'m';'n';'o';'p';'q';'r';'s';'t';'u';'v';'w';'x';'y';'z'];

file = [FileName(1:end-4) '.txt'];

fileID = fopen(file,'w');
for i = 1:size(p,1)
    if p(i,2)==0
        fprintf(fileID,'%1s',key(p(i,1)));
    elseif p(i,2) == 1
        fprintf(fileID,'%1s ',key(p(i,1)));
    else
        fprintf(fileID,'%1s\n',key(p(i,1)));
    end
end
fclose(fileID);
open(file);

% str = [];
% for i = 1:size(p,1)
%     if p(i,2)==0
%         str = [str sprintf('%1s',key(p(i,1)))];
%     elseif p(i,2) == 1
%         str = [str sprintf('%1s ',key(p(i,1)))];
%     else
%         str = [str sprintf('%1s\n',key(p(i,1)))];
%     end
% end
% fprintf('%s\n',str);