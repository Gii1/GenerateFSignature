function jsontext = encodeSignatureToJson(signature)
    % This function encodes an array of FunctionSignature-objects as a
    % struct which can be parsed using jsonencode to create valid
    % functionsignature.json files

    % Loop through all signatures
    for i = 1:length(signature)
        s = signature(i);
        functionstruct = struct();

        % Add input 
        if ~isempty(s.inputs)
            functionstruct.inputs = table([s.inputs.name]', ...
                repmat("required", length(s.inputs), 1), ...
                repmat("", length(s.inputs), 1), ...
                VariableNames=["name", "kind", "type"]);
        end

        if ~isempty(s.outputs)
            functionstruct.outputs = table([s.outputs.name]', ...
                repmat("", length(s.outputs), 1), ...
                VariableNames=["name", "type"]);
        end

        % escape function name
        funcname = escapestring(s.name);

        filestruct.(funcname) = functionstruct;
    end

    % encode to json and unescape
    jsontext = unescapestring(jsonencode(filestruct, PrettyPrint=true));
end