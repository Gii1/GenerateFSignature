function tests = testEncodeSignatureToJson()
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
    % Add parent to path
    testCase.applyFixture(matlab.unittest.fixtures.PathFixture("../../"))
end

% test signature with 2 input variables
function testFunctionWithInputs(testCase)
    signature = gfs.FunctionSignature("functionwithoutputs", inputs=["var1", "var2"]);
    jsontext = join(readlines("testdataEncodeSignatureToJson\functionwithinputs.json"));
    verifyEqual(testCase, jsonencode(gfs.encodeSignatureToJson(signature)), jsonencode(jsontext));
end

% test signature with 2 output variables
function testFunctionWithOutputs(testCase)
    signature = gfs.FunctionSignature("functionwithoutputs", outputs=["var1", "var2"]);
    jsontext = join(readlines("testdataEncodeSignatureToJson\functionwithoutputs.json"));
    verifyEqual(testCase, jsonencode(gfs.encodeSignatureToJson(signature)), jsonencode(jsontext));
end