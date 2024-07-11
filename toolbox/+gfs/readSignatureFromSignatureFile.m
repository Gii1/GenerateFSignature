 function signature = readSignatureFromSignatureFile(filename)
    % readSignatureFromSignatureFile reads the content of a function
    % signature file and parses it to an array of FunctionSignature
    % objects. 
    % read file text and escape it
    filetext = escapestring(fileread(filename));
    % parses content to structure object
    signaturestruct = jsondecode(filetext);

    % get all function names
    functionnames = string(fieldnames(signaturestruct));
    % initialize array
    signature(length(functionnames)) = gfs.FunctionSignature;

    % count all valid function objects
    k = 0;
    for i = 1:length(functionnames)
        % get structure associated with function
        functionstruct = signaturestruct.(functionnames(i));

        % sort out empty functions
        if ~isfield(functionstruct, "inputs") && ~isfield(functionstruct, "outputs")
            break;
        end

        % create signature object
        signature(k+1) = gfs.FunctionSignature(unescapestring(functionnames(i)));

        % check if input   
        if isfield(functionstruct, "inputs")
            signature(i).addInputs(string({functionstruct.inputs.name}), ...
                kind=string({functionstruct.inputs.kind}), ...
                type=unescapestring(string({functionstruct.inputs.type})));
        end

        if isfield(functionstruct, "outputs")
            signature(i).addOutputs(string({functionstruct.outputs.name}), ...
                type=unescapestring(string({functionstruct.outputs.type})));
        end

        k = k + 1;
    end

    signature = signature(1:k);
end