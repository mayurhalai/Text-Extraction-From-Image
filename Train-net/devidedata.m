c = size(source,2);
t = ceil(numc*0.7);
input=[];
trget=[];
tsource=[];
ttarget=[];
for i=1:c
    rnk = mod(i,numc);
    if rnk < t
        input = [input source(:,i)];
        trget = [trget target(:,i)];
    else
        tsource = [tsource source(:,i)];
        ttarget = [ttarget target(:,i)];
    end
end
input = transpose(input);
trget = transpose(trget);
tsource = transpose(tsource);
ttarget = transpose(ttarget);