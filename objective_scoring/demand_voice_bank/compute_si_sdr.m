function si_sdr = compute_si_sdr(ref, enh)
    scale = (enh'*ref) / (sum(ref.^2));
    ref_scaled = scale*ref;
    si_sdr = 10*log10(sum(ref_scaled.^2) / sum((ref_scaled-enh).^2));