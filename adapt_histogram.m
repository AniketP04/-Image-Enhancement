function result = adapt_histogram(img)
    img_gray = rgb2gray(img);
    img_gray_eq = histeq(img_gray);
    result = cat(3, img_gray_eq, img(:, :, 2), img(:, :, 3));
end