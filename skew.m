function fim = skew(th)
    maximum = 0;
    for i=1:40
        angle = i-20;
        tmp = imrotate(th,angle);
        his = sum(tmp,2);
        m = sort(his,'descend');
        m = mean(m(1:5,1));
        if maximum < m
            maximum = m;
            sangle = angle;
        end
    end
    fim = imrotate(th,sangle);
end