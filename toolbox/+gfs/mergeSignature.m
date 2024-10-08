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

    % merge input
    if ~isempty(newsignature.inputs)
        mergeInputStruct(oldsignature, newsignature, mergedsignature);
    end

    %merge output
    if ~isempty(newsignature.outputs)
        mergeOutputStruct(oldsignature, newsignature, mergedsignature);
    end
end

function mergeInputStruct(oldsignature, newsignature, mergedsignature)
    % search for same variable name in new and old signature
    [idxnew, idxold] = ismember([newsignature.inputs.name], string([oldsignature.inputs.name]));
    % create struct for input vars
    inputvars = newsignature.inputs;
    inputvars(idxnew) = oldsignature.inputs(idxold(idxnew));

    % check for varargin
    remainingidx = ~ismember(1:length(oldsignature.inputs), idxold);
    if strcmp(inputvars(end).name, "varargin") && any(remainingidx)
        inputvars(end) = [];
        inputvars = [inputvars, oldsignature.inputs(remainingidx)];
    end

    % add input vars to mergedsignature
    mergedsignature.addInputStruct(inputvars);
end

function mergeOutputStruct(oldsignature, newsignature, mergedsignature)
    % search for same variable name in new and old signature
    [idxnew, idxold] = ismember([newsignature.outputs.name], string([oldsignature.outputs.name]));
    % create struct for output vars
    outputvars = newsignature.outputs;
    outputvars(idxnew) = oldsignature.outputs(idxold(idxnew));

    % check for varargout
    remainingidx = ~ismember(1:length(oldsignature.outputs), idxold);
    if strcmp(outputvars(end).name, "varargout") && any(remainingidx)
        outputvars(end) = [];
        outputvars = [outputvars, oldsignature.outputs(remainingidx)];
    end

    % add output vars to mergedsignature
    mergedsignature.addOutputStruct(outputvars);
end
