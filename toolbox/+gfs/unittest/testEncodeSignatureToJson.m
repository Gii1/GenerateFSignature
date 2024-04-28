function tests = testEncodeSignatureToJson()
    tests = functiontests(localfunctions);
end

% test signature with 2 input variables
function testFunctionWithInputs(testCase)
    signature = gfs.FunctionSignature("functionwithinputs");
    signature.addInputs(["var1", "var2"]);
    jsontext = join(readlines("testdata/testEncodeSignatureToJson/functionwithinputs.json"));
    verifyEqual(testCase, jsondecode(gfs.encodeSignatureToJson(signature)), jsondecode(jsontext));
end

% test signature with 2 output variables
function testFunctionWithOutputs(testCase)
    signature = gfs.FunctionSignature("functionwithoutputs");
    signature.addOutputs(["var1", "var2"]);
    jsontext = join(readlines("testdata/testEncodeSignatureToJson/functionwithoutputs.json"));
    verifyEqual(testCase, jsondecode(gfs.encodeSignatureToJson(signature)), jsondecode(jsontext));
end