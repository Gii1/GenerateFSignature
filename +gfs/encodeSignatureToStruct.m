function filestruct = encodeSignatureToStruct(signature)
    for i = 1:length(signature)
        s = signature(i);

        if ~isempty(s.inputs)
            functionstruct.inputs = struct("name", {s.inputs.name}, "type", "required", "kind", "");
        end

        if ~isempty(s.outputs)
            functionstruct.outputs = struct("name", {s.outputs.name}, "type", "required", "kind", "");
        end

        filestruct.(s.name) = functionstruct;
    end
end