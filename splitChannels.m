function [c1, c2, c3, c4] = splitChannels(img)
    c1 = img(:, :, 1);
    c2 = img(:, :, 2);
    c3 = img(:, :, 3);
end