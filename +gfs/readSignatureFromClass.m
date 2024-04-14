function sign = readSignatureFromClass(node)
    % convert a mtree class node into an array of FunctionSignature object
    sign = gfs.FunctionSignature.empty;
    name = node.Cexpr.stringval;

    % test for class with no functions
    if isempty(node.Body); return; end

    % Loop over all function nodes in class
    functionnode = node.Body.Body;
    while ~isempty(functionnode)
        % convert function node to FunctionSignature object
        funcsign = gfs.readSignatureFromFunction(functionnode);
        % add class name to the function name
        funcsign.name = strcat(name, ".", funcsign.name);
        % add new signature to list
        sign(end+1) = funcsign;
        functionnode = functionnode.Next;
    end
end