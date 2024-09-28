function tests = testMergeSignature()
    tests = functiontests(localfunctions);
end

% type in old and new signature are different
% output should be type of old signature
function testDifferentType(testCase)
    oldsignature = gfs.FunctionSignature("function");
    oldsignature.addInputs("var1", kind="required", type="numeric");
    newsignature = gfs.FunctionSignature("function");
    newsignature.addInputs("var1", kind="required", type="");
    
    expected = gfs.FunctionSignature("function");
    expected.addInputs("var1", kind="required", type="numeric");
    actual = gfs.mergeSignature(oldsignature, newsignature);
    testCase.verifyEqual(actual, expected);
end

% kind in old and new signature are different
% output kind should be kind of old signature
function testDifferentKind(testCase)
    oldsignature = gfs.FunctionSignature("function");
    oldsignature.addInputs("var1", kind="namevalue", type="");
    newsignature = gfs.FunctionSignature("function");
    newsignature.addInputs("var1", kind="required", type="");

    expected = gfs.FunctionSignature("function");
    expected.addInputs("var1", kind="namevalue", type="");
    actual = gfs.mergeSignature(oldsignature, newsignature);
    testCase.verifyEqual(actual, expected);
end

% new signature has different amount of input arguments than old signature
% input arguments should be the arguments of new signature
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

% new signature has different amount of output arguments than old signature
% output arguments should be the arguments of new signature
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