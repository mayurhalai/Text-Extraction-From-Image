function fe = fvect(im)
    im = imresize(im,[32 32]);
    fe = im(:);
end