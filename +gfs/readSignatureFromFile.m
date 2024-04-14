function sign = readSignatureFromFile(filename)
    node = mtree(filename, "-file").root;

    switch node.kind
        case "FUNCTION"
            sign = gfs.readSignatureFromFunction(node);
        case "CLASSDEF"
            sign = gfs.readSignatureFromClass(node);
        otherwise
            sign = [];
    end
end

