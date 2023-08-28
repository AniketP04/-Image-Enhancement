function result = homomorphic(img)
    img = double(img) / 255;
    [rows, cols, dim] = size(img);

    rh = 1.3;
    rl = 0.8;
    cutoff = 32;

    [b, g, r] = splitChannels(img);
    y_log_b = log(b + 0.01);
    y_log_g = log(g + 0.01);
    y_log_r = log(r + 0.01);

    y_fft_b = fft2(y_log_b);
    y_fft_g = fft2(y_log_g);
    y_fft_r = fft2(y_log_r);

    y_fft_shift_b = fftshift(y_fft_b);
    y_fft_shift_g = fftshift(y_fft_g);
    y_fft_shift_r = fftshift(y_fft_r);

    D0 = cols / cutoff;
    H = ones(rows, cols);
    
    for i = 1:rows
        for j = 1:cols
            H(i, j) = ((rh - rl) * (1 - exp(-((i - rows / 2)^2 + (j - cols / 2)^2) / (2 * D0^2)))) + rl;
        end
    end
    
    result_filter_b = H .* y_fft_shift_b;
    result_filter_g = H .* y_fft_shift_g;
    result_filter_r = H .* y_fft_shift_r;

    result_interm_b = real(ifft2(ifftshift(result_filter_b)));
    result_interm_g = real(ifft2(ifftshift(result_filter_g)));
    result_interm_r = real(ifft2(ifftshift(result_filter_r)));

    result_b = exp(result_interm_b);
    result_g = exp(result_interm_g);
    result_r = exp(result_interm_r);

    result = zeros(rows, cols, dim);
    result(:, :, 1) = result_b;
    result(:, :, 2) = result_g;
    result(:, :, 3) = result_r;
end