function sign = readSignatureFromFunction(node)
    % convert a mtree function node into a FunctionSignature object

    name = node.Fname.stringval;
    inputs = string.empty;
    outputs = string.empty;

    inputnode = node.Ins;
    while ~isempty(inputnode)
        inputs(end+1) = string(inputnode.stringval);
        inputnode = inputnode.Next;
    end

    outputnode = node.Outs;
    while ~isempty(outputnode)
        outputs(end+1) = string(outputnode.stringval);
        outputnode = outputnode.Next;
    end

    if isempty(inputs) && isempty(outputs)
        sign = gfs.FunctionSignature.empty;
        return;
    end
    
    sign = gfs.FunctionSignature(name);

    if ~isempty(inputs)
        sign.addInputs(inputs);
    end

    if ~isempty(outputs)
        sign.addOutputs(outputs);
    end
end