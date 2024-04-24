function writeSignatureToFile(signature, path)
    % writes an array of signatures to a file specified by path

    % convert signatures to structure
    text = gfs.encodeSignatureToJson(signature);
    % write structure to file as json
    writelines(text, path);
end