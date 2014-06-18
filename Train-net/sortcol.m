
function sortmat= sortcol(boxmat)
%This Function is made to sort the columns row wise so as to get continuous
%letter indicators to analyse letters.

%   box mat contains upper left point in first and third column.first column
%   represents row and the input it is already sorted on first row.For the
%   range of each row the function sorts the columns in a recursive way.


%% return input if it is for only one element
ind = boxmat;
m1 = size(ind,1);
if m1 == 1
sortmat = ind;
return
end

%% count the number of element in a straight row of image
i = 1;
while ind(i+1,1) < ind(1,3)
    i = i+1;
    if i == m1
        break
    end
end
%% recursive call
sr = sortrows(ind(1:i,:),2);
if i == m1
    sortmat = sr;
else
    sortmat = [sr;sortcol(ind(i+1:m1,:))];


end
