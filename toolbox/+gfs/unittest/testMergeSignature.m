function tests = testMergeSignature()
    tests = functiontests(localfunctions);
end

% input variables are different
function testDifferentInputVar(testCase)
    oldsignature = gfs.FunctionSignature("function");
    oldsignature.addInputs("var1", kind="required", type="numeric");
    newsignature = gfs.FunctionSignature("function");
    newsignature.addInputs("var1", kind="required", type="nan");
    
    expected = gfs.FunctionSignature("function");
    expected.addInputs("var1", kind="required", type="numeric");
    actual = gfs.mergeSignature(oldsignature, newsignature);
    testCase.verifyEqual(actual, expected);
end

% input variables are different
function testDifferentOutputVar(testCase)
    oldsignature = gfs.FunctionSignature("function");
    oldsignature.addOutputs("var1", type="numeric");
    newsignature = gfs.FunctionSignature("function");
    newsignature.addOutputs("var1", type="nan");
    
    expected = gfs.FunctionSignature("function");
    expected.addOutputs("var1", type="numeric");
    actual = gfs.mergeSignature(oldsignature, newsignature);
    testCase.verifyEqual(actual, expected);
end

% number of input variables differs
function testInputArgumentsDiffer(testCase)
    oldsignature = gfs.FunctionSignature("function");
    oldsignature.addInputs("var1", kind="required", type="");
    newsignature = gfs.FunctionSignature("function");
    newsignature.addInputs(["var1", "var2"], kind="required", type="");   

    expected = gfs.FunctionSignature("function");
    expected.addInputs(["var1", "var2"], kind="required", type="");
    actual = gfs.mergeSignature(oldsignature, newsignature);
    testCase.verifyEqual(actual, expected);
end

% number of output variables differs
function testOutputArgumentsDiffer(testCase)
    oldsignature = gfs.FunctionSignature("function");
    oldsignature.addOutputs("var1", type="");
    newsignature = gfs.FunctionSignature("function");
    newsignature.addOutputs(["var1", "var2"], type="");   
    
    expected = gfs.FunctionSignature("function");
    expected.addOutputs(["var1", "var2"], type="");
    actual = gfs.mergeSignature(oldsignature, newsignature);
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
    actual = gfs.mergeSignature(oldsignature, newsignature);
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
    actual = gfs.mergeSignature(oldsignature, newsignature);
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
    actual = gfs.mergeSignature(oldsignature, newsignature);
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
    actual = gfs.mergeSignature(oldsignature, newsignature);
    testCase.verifyEqual(actual, expected);
end