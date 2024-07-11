function merged = mergeSignatureArray(oldsignature, newsignature)
    % mergeSignature merges the old signature array read from the signature file
    % with the new signature array read from the mfiles.

    merged = createArray(size(newsignature), "gfs.FunctionSignature");

    % Loop through all new signatures
    for i = 1:length(newsignature)
        sign = newsignature(i);
        oldsignidx = find(strcmp([oldsignature.name], sign.name), 1);

        % check if the element is also present in the old signature
        if ~isempty(oldsignidx)
            merged(i) = gfs.mergeSignature(oldsignature(oldsignidx), sign);
        else
            merged(i) = sign;
        end
    end
end