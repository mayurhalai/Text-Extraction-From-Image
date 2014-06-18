function THC = cchar(TH)
% load('Img.mat');
% filename = ['English\Img\' img.ALLnames(14,:) '.png'];
% im = imread(filename);
% filename = ['English\Img\' img.ALLmasks(14,:) '.png'];
% msk = imread(filename);
% TH = tchar(im,msk);
CC = bwconncomp(TH);
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

m = [boxmat(1,5) 1];
for i=1:m1
    if (boxmat(i,5)>m(1))
        m = [boxmat(i,5) i];
    end
end

ind = m(2);
temp = enough{1,ind};
x = mod(temp,rn*ones(size(temp)));
y = ceil(temp./rn);
x = x - boxmat(ind,1);
y = y - boxmat(ind,2);
THC = zeros(boxmat(ind,3)-boxmat(ind,1),boxmat(ind,4)-boxmat(ind,2));
for k = 1:size(temp)
    if (x(k)~=0 && y(k)~=0)
        THC(x(k),y(k))=1;
    end
end
end