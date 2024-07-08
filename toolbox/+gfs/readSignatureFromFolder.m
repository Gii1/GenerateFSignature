function sign = readSignatureFromFolder(foldername)
    filenames = string({dir(fullfile(foldername, "*.m")).name});
    sign = gfs.FunctionSignature.empty;
    isinvalid = false(size(filenames));

    for i = 1:length(filenames)
        try
            sign = [sign gfs.readSignatureFromFile(fullfile(foldername, filenames(i)))]; %#ok<AGROW>
        catch ME
            if strcmp(ME.identifier, "gfs:invalidfile")
                isinvalid(i) = true;
            else
                ME.rethrow()
            end
        end
    end

    if any(isinvalid)
        MException("gfs:invalidfile", "The following files could not be parsed: %s", join(filenames(isinvalid), ", ")).throw();
    end
end