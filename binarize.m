function TH = binarize(im)
if (size(im,3)~=1)
    im = rgb2gray(im);
end
E = edge(medfilt2(im,[3 3]),'canny',0.2);
CC = bwconncomp(E);
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

[r, c] = size(im);
ind1 = r/c;
ind2 = mean(boxmat(:,3)-boxmat(:,1))*4;
ind3 = mean(boxmat(:,4)-boxmat(:,2))*4;
asp = ind2/ind3;
for i = 1:m1
    if (boxmat(i,5) < ind1 || asp>10 || asp<0.1)
        boxmat(i,:) = 0;
    end
end

% ind = mean(boxmat(:,5))/6;
% for i = 1:m1
%     if boxmat(i,5) < ind
%         boxmat(i,:) = 0;
%     end
% end

for i = 1:m1
    nint=0;
    trace=[];
    for j=1:m1
        if (boxmat(j,1)>boxmat(i,1) && boxmat(j,2)>boxmat(i,2) && boxmat(j,3)<boxmat(i,3) && boxmat(j,4)<boxmat(i,4))
            nint=nint+1;
            trace(nint,1)=j;
        end
    end
    if nint<3
        for k=1:nint
            boxmat(trace(k,1),:)=0;
        end
    else
        boxmat(i,:)=0;
    end
end

boxmat = sortrows(boxmat,1);
sb=size(boxmat,1);
i = 1;
while boxmat(i,1)==0 && i<sb
    i = i+1;
end

[r, c] = size(E);
TH = zeros(r,c);
boxmat = boxmat(i:m1,:);
sb=size(boxmat,1);
for i=1:sb
    n=0;
    fb=[];
    x1=boxmat(i,1);
    y1=boxmat(i,2);
    x2=boxmat(i,3);
    y2=boxmat(i,4);
    for j=x1:x2
        for k=y1:y2
            if E(j,k)
                fb = [fb im(j,k)];
                n=n+1;
            end
        end
    end
    fb = mean(fb);
    bb = median([im(x1-1,y1-1), im(x1-1,y1), im(x1,y1-1), im(x1+1,y2-1), im(x1,y2-1), im(x1+1,y2), im(x2-1,y1+1), im(x2-1,y1), im(x2,y1+1), im(x2+1,y2+1), im(x2,y2+1), im(x2+1,y2)]);
    if fb<bb
        for j=x1:x2
            for k=y1:y2
                if im(j,k)<fb
                    TH(j,k)=1;
                end
            end
        end
    else
        for j=x1:x2
            for k=y1:y2
                if im(j,k)>=fb
                    TH(j,k)=1;
                end
            end
        end
    end
end
end