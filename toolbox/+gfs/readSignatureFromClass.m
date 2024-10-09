function sign = readSignatureFromClass(node)
    % convert a mtree class node into an array of FunctionSignature object
    
    sign = gfs.FunctionSignature.empty;

    % get name of class
    if strcmp(node.Cexpr.kind, "ID")
        name = string(node.Cexpr.stringval);
    else
        name = string(node.Cexpr.Left.stringval);
    end

    % test if class has no functions
    if isempty(node.Body); return; end

    % Loop over all method blocks
    methodnodes = node.Body.list.mtfind("Kind", "METHODS");
    for i = methodnodes.indices()
        % Loop over all function nodes
        functionnodes = methodnodes.select(i).Body.list;
        for j = functionnodes.indices()
            funcsign = gfs.readSignatureFromFunction(functionnodes.select(j));

            % set signature parameters
            if strcmp(name, funcsign.name)
                funcsign.outputs.type = name;
            else
                funcsign.inputs(1).kind = "required";
                funcsign.inputs(1).type = name;
            end

            funcsign.name = strcat(name, ".", funcsign.name);

            % add signature to list
            sign(end+1) = funcsign;
        end
    end
end