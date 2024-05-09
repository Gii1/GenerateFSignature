function mergedsignature = mergeSignature(oldsignature, newsignature)
    % mergeSignature merges the old signature read from the
    % FunctionSignature.json with the new signature read from the mfiles.
    % It is expected that both signatures refer to the same function.

    arguments
        oldsignature gfs.FunctionSignature;
        newsignature gfs.FunctionSignature;
    end

    % create a new functionsignature object
    mergedsignature = gfs.FunctionSignature(oldsignature.name);

    % iterate over every item in the input of the new signature
    for i = 1:length(newsignature.inputs)
        % find corresponding item in old signature
        newinputvar = newsignature.inputs(i);
        oldinputvar = oldsignature.inputs([oldsignature.inputs.name] == newinputvar.name);

        name = newinputvar.name;
        kind = newinputvar.kind;
        type = newinputvar.type;

        % override parameters of new signature with old ones
        if ~isempty(oldinputvar)
            kind = oldinputvar.kind;
            type = oldinputvar.type;
        end

        % add parameters as new input var
        mergedsignature.addInputs(name, kind=kind, type=type);
    end

    % same procedure for old signature
    for i = 1:length(newsignature.outputs)
        % find corresponding item in old signature
        newinputvar = newsignature.outputs(i);
        oldinputvar = oldsignature.outputs([oldsignature.outputs.name] == newinputvar.name);

        name = newinputvar.name;
        type = newinputvar.type;

        % override parameters of new signature with old ones
        if ~isempty(oldinputvar)
            type = oldinputvar.type;
        end

        % add parameters as new input var
        mergedsignature.addOutputs(name, type=type);
    end
end