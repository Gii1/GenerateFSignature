function tests = testEncodeSignatureToJson()
    tests = functiontests(localfunctions);
end

% test signature with 2 input variables
function testFunctionWithInputs(testCase)
    expectedtext = join(readlines("testdata/testEncodeSignatureToJson/functionwithinputs.json"));
    actualsignature = gfs.FunctionSignature("functionwithinputs");
    actualsignature.addInputs(["var1", "var2"]);

    expected = jsondecode(expectedtext);
    actual = jsondecode(gfs.encodeSignatureToJson(actualsignature));
    verifyEqual(testCase, actual, expected);
end

% test signature with 2 output variables
function testFunctionWithOutputs(testCase)
    expectedtext = join(readlines("testdata/testEncodeSignatureToJson/functionwithoutputs.json"));
    actualsignature = gfs.FunctionSignature("functionwithoutputs");
    actualsignature.addOutputs(["var1", "var2"]);

    expected = jsondecode(expectedtext);
    actual = jsondecode(gfs.encodeSignatureToJson(actualsignature));
    verifyEqual(testCase, actual, expected);
end

% test class function
function testFunctionWithDot(testCase)
    expectedtext = join(readlines("testdata/testEncodeSignatureToJson/functionwithdot.json"));
    actualsignature = gfs.FunctionSignature("class.function");
    actualsignature.addInputs("var1");
    
    expected = jsondecode(expectedtext);
    actual = jsondecode(gfs.encodeSignatureToJson(actualsignature));
    verifyEqual(testCase, actual, expected);
end