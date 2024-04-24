function generateFunctionSignature(path)
    arguments
        path (1, 1) string = "./"
    end

    import gfs.*;

    sign = readSignatureFromFolder(path);

    if isempty(sign)
        disp("This folder is empty");
        return
    end

    mkdir(fullfile(path, "resources"));

    if isfile(fullfile(path, "resources", "functionSignatures.json"))
        if ~strcmp(input("There is already a signature file in the folder. Generate the signature file anyway? (Enter yes):", "s"), "yes")
            return
        end
    end

    gfs.writeSignatureToFile(sign, fullfile(path, "resources", "functionSignatures.json"));
end