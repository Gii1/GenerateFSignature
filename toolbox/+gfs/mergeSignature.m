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

    isused = false(length(oldsignature.inputs), 1);

    % iterate over every item in the input of the new signature
    for i = 1:length(newsignature.inputs)
        newinputvar = newsignature.inputs(i);

        if strcmp(newinputvar.name, "varargin") && any(~isused)
            mergedsignature.addInputStruct(oldsignature.inputs(~isused));
        else
            name = newinputvar.name;
            kind = newinputvar.kind;
            type = newinputvar.type;

            oldidx = find(strcmp([oldsignature.inputs.name], newinputvar.name), 1);
            
            % check if var exists in old signature
            if ~isempty(oldidx)
                % override parameters of new signature with old ones
                isused(oldidx) = true;
                oldinputvar = oldsignature.inputs(oldidx);
                kind = oldinputvar.kind;
                type = oldinputvar.type;
            end

            % add parameters as new input var 
            mergedsignature.addInputs(name, kind=kind, type=type);
        end
    end

    % same procedure for output
    for i = 1:length(newsignature.outputs)
        % find corresponding item in old signature
        newinputvar = newsignature.outputs(i);
        oldinputvar = oldsignature.outputs(strcmp([oldsignature.outputs.name], newinputvar.name));

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