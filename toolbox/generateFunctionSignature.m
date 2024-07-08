function generateFunctionSignature(path)
    arguments
        path (1, 1) string = "./"
    end

    import gfs.*;

    newsign = readSignatureFromFolder(path);

    if isempty(newsign)
        disp("This folder is empty");
        return
    end

    if isfile(fullfile(path, "resources", "functionSignatures.json"))
        copyfile(fullfile(path, "resources", "functionSignatures.json"), fullfile(path, "resources", "functionSignatures_old.json"))
        oldsign = readSignatureFromSignatureFile(fullfile(path, "resources", "functionSignatures.json"));
        newsign = mergeSignatureArray(oldsign, newsign);
    end

    mkdir(fullfile(path, "resources"));

    gfs.writeSignatureToFile(newsign, fullfile(path, "resources", "functionSignatures.json"));
end