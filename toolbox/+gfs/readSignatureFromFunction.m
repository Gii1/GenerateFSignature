function sign = readSignatureFromFunction(node)
    % convert a mtree function node into a FunctionSignature object

    % get function name
    name = node.Fname.stringval;

    % get argument names for input and output
    inputs = string(node.Ins.List.stringvals);
    outputs = string(node.Outs.List.stringvals);

    if isempty(inputs) && isempty(outputs)
        % return empty object when the function has no input and output
        % arguments
        sign = gfs.FunctionSignature.empty;
    else
        % else return parsed function signature
        sign = gfs.FunctionSignature(name);
        sign.addInputs(inputs);
        sign.addOutputs(outputs);
    end
end