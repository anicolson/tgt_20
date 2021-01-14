function sdr = compute_sdr(ref, enh)
    sdr = 10*log10(sum(ref.^2) / sum((ref-enh).^2));