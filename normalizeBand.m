function normalizedBand = normalizeBand(img, minO, maxO)
    minI = min(img(:));
    maxI = max(img(:));
    
    normalizedBand = (img - minI) .* (((maxO - minO) / (maxI - minI)) + minO);
end