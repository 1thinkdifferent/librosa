function makeTestData(source_path, output_path)
% makeTestData(source_path, audio_file, output_path)
%   source_path = path to DPWE code
%   output_ptah = directory to store generated files
%
% CREATED:2013-03-08 14:32:21 by Brian McFee <brm2132@columbia.edu>
%   Generate the test suite data for librosa comparison.
%
%   Validated methods:
%       hz_to_mel
%       mel_to_hz
%       hz_to_octs
%
%       dctfb               
%       melfb
%
%       localmax
%
%       stft
%       istft
%
%       load
%

    % Make sure we have the path to DPWE code
    addpath(source_path);

    display('hz_to_mel');
    makeTestHz2Mel(output_path);

    display('mel_to_hz');
    makeTestMel2Hz(output_path);

    display('hz_to_octs');
    makeTestHzToOcts(output_path);

    display('load');
    makeTestLoad(output_path);

    %% Done!
    display('Done.');
end

function makeTestHz2Mel(output_path)

    % Test with either a scalar argument or a vector
    P_HZ = {[440], [2.^(1:13)]};

    % Slaney-style or HTK
    P_HTK         = {0, 1};

    counter     = 0;
    for i = 1:length(P_HZ)
        f = P_HZ{i};

        for j = 1:length(P_HTK)
            htk = P_HTK{j};
        
            % Run the function
            result = hz2mel(f, htk);

            % save the output
            counter = counter + 1;

            filename = sprintf('%s/hz_to_mel-%03d.mat', output_path, counter);
            display(['  `-- saving ', filename]);

            save(filename, 'f', 'htk', 'result');
        end
    end
end

function makeTestMel2Hz(output_path)

    % Test with either a scalar argument or a vector
    P_MELS      = {[5], [2.^(-2:9)]};

    % Slaney-style or HTK
    P_HTK       = {0, 1};

    counter     = 0;
    for i = 1:length(P_MELS)
        f = P_MELS{i};

        for j = 1:length(P_HTK)
            htk = P_HTK{j};
        
            % Run the function
            result = mel2hz(f, htk);

            % save the output
            counter = counter + 1;

            filename = sprintf('%s/mel_to_hz-%03d.mat', output_path, counter);
            display(['  `-- saving ', filename]);

            save(filename, 'f', 'htk', 'result');
        end
    end
end

function makeTestHzToOcts(output_path)

    % Scalar argument or a vector
    P_HZ      = {[5], [2.^(2:14)]};

    counter     = 0;
    for i = 1:length(P_HZ)
        f = P_HZ{i};

        % Run the function
        result = hz2octs(f);

        % save the output
        counter = counter + 1;

        filename = sprintf('%s/hz_to_octs-%03d.mat', output_path, counter);
        display(['  `-- saving ', filename]);

        save(filename, 'f', 'result');
    end
end

function makeTestLoad(output_path)

    % Test: load a wav file
    %       get audio stream (floats) and sample rate
    %       preserve stereo or convert to mono
    infile          = 'data/test1.wav';
    [y, sr]         = wavread(infile);
    mono            = 0;

    % Stereo output
    counter = 1;

    filename = sprintf('%s/load-%03d.mat', output_path, counter);
    display(['  `-- saving ', filename]);
    save(filename, 'infile', 'mono', 'y', 'sr');

    % Mono output
    counter = 2;
    mono    = 1;
    y       = mean(y, 2);
    filename = sprintf('%s/load-%03d.mat', output_path, counter);
    display(['  `-- saving ', filename]);
    save(filename, 'infile', 'mono', 'y', 'sr');

end
