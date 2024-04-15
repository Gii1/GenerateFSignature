function sign = readSignatureFromFile(filename)
    node = mtree(filename, "-file").root;

    switch node.kind
        case "FUNCTION"
            sign = gfs.readSignatureFromFunction(node);
        case "CLASSDEF"
            sign = gfs.readSignatureFromClass(node);
        case "ERR"
            MException("gfs:invalidfile", "The mfile could not be parsed.").throw();
        otherwise
            sign = [];
    end
end

