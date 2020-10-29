% AUTHOR:         Aaron Nicolson
% AFFILIATION:    Signal Processing Laboratory, Griffith University
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function results = add_score(score, results, noise_src, snr)
    if results.isKey(noise_src, snr)
        results(noise_src, snr) = [score; results(noise_src, snr)];
    else
        results(noise_src, snr) = score;
    end
end
% EOF
