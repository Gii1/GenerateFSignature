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

% signature contains varargin
% add all variables in old signature to the list instead of varargin
function testFunctionContainsVarargin(testCase)
    oldsignature = gfs.FunctionSignature("func");
    oldsignature.addInputs(["var1", "var2"], type="null");
    newsignature = gfs.FunctionSignature("func");
    newsignature.addInputs("varargin");

    expected = gfs.FunctionSignature("func");
    expected.addInputs(["var1", "var2"], type="null");
    actual = gfs.mergeSignatureArray(oldsignature, newsignature);
    testCase.verifyEqual(actual, expected);
end

% signature contains varargin, old signature contains not enough vars
% add varargin normally to the var list
function testFunctionContainsVarargin2(testCase)
    oldsignature = gfs.FunctionSignature("func");
    newsignature = gfs.FunctionSignature("func");
    newsignature.addInputs("varargin");    

    expected = gfs.FunctionSignature("func");
    expected.addInputs("varargin");
    actual = gfs.mergeSignatureArray(oldsignature, newsignature);
    testCase.verifyEqual(actual, expected);
end

% signature contains varargout
% add all variables in the old signature to the list instead of varargout
function testFunctionContainsVarargout(testCase)
    oldsignature = gfs.FunctionSignature("func");
    oldsignature.addOutputs(["var1", "var2"], type="null");
    newsignature = gfs.FunctionSignature("func");
    newsignature.addOutputs("varargout");

    expected = gfs.FunctionSignature("func");
    expected.addOutputs(["var1", "var2"], type="null");
    actual = gfs.mergeSignatureArray(oldsignature, newsignature);
    testCase.verifyEqual(actual, expected);
end

% signature contains varargout, old signature contains not enough vars
% add varargout normally to the var list
function testFunctionContainsVarargout2(testCase)
    oldsignature = gfs.FunctionSignature("func");
    newsignature = gfs.FunctionSignature("func");
    newsignature.addOutputs("varargout");    

    expected = gfs.FunctionSignature("func");
    expected.addOutputs("varargout");
    actual = gfs.mergeSignatureArray(oldsignature, newsignature);
    testCase.verifyEqual(actual, expected);
end