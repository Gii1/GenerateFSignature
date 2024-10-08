function tests = testMergeSignatureArray()
    tests = functiontests(localfunctions);
end

% function exist in old signature and not in new
% output should not include any old signature which is not in the new
% signature
function testOnlyInOldSignature(testCase)
    oldsignature = gfs.FunctionSignature("function");
    newsignature = gfs.FunctionSignature.empty;

    expected = gfs.FunctionSignature.empty;
    actual = gfs.mergeSignatureArray(oldsignature, newsignature);
    testCase.verifyEqual(actual, expected);
end

% function exist in new signature and not in old
% output should include any new signature, even if it not in old
function testOnlyInNewSignature(testCase)
    oldsignature = gfs.FunctionSignature.empty;
    newsignature = gfs.FunctionSignature("function");

    expected = gfs.FunctionSignature("function");
    actual = gfs.mergeSignatureArray(oldsignature, newsignature);
    testCase.verifyEqual(actual, expected);
end

% function exist both in old and new signature
% output should include the merged signature from new and old
function testBothNewAndOldSignature(testCase)
    oldsignature = gfs.FunctionSignature("function");
    newsignature = gfs.FunctionSignature("function");
    
    expected = gfs.FunctionSignature("function");
    actual = gfs.mergeSignatureArray(oldsignature, newsignature);
    testCase.verifyEqual(actual, expected);
end