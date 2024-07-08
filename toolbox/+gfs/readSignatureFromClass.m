function sign = readSignatureFromClass(node)
    % convert a mtree class node into an array of FunctionSignature object
    
    sign = gfs.FunctionSignature.empty;

    % get name of class
    if strcmp(node.Cexpr.kind, "ID")
        name = node.Cexpr.stringval;
    else
        name = node.Cexpr.Left.stringval;
    end

    % test if class has no functions
    if isempty(node.Body); return; end

    % Loop over content of node body
    bodynode = node.Body;
    while ~isempty(bodynode)
        % Check if body node is a methods node
        if strcmp(bodynode.kind, "METHODS")
            % Loop over all function nodes in class
            functionnode = bodynode.Body;
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

        bodynode = bodynode.Next;
    end
end