function tests = testReadSignatureFromSignatureFile
    tests = functiontests(localfunctions);
end

% test function signature with 2 input variables
function testFunctionWithInputs(testCase)
    inputfile = "testdata/testReadSignatureFromSignatureFile/functionwithinput.json";
    expectedSignature = gfs.FunctionSignature("function");
    expectedSignature.addInputs(["var1", "var2"], kind="required", type="numeric");
    testCase.verifyEqual(gfs.readSignatureFromSignatureFile(inputfile), expectedSignature);
end

function testFunctionWithOutputs(testCase)
    inputfile = "testdata/testReadSignatureFromSignatureFile/functionwithoutputs.json";
    expectedSignature = gfs.FunctionSignature("function");
    expectedSignature.addOutputs(["var1", "var2"], type="numeric");
    testCase.verifyEqual(gfs.readSignatureFromSignatureFile(inputfile), expectedSignature);
end

function testMultipleFunction(testCase)
    inputfile = "testdata/testReadSignatureFromSignatureFile/multiplefunctions.json";
    expectedSignature(1) = gfs.FunctionSignature("function1");
    expectedSignature(1).addInputs("var1", kind="required", type="numeric");
    expectedSignature(2) = gfs.FunctionSignature("function2");
    expectedSignature(2).addInputs("var1", kind="required", type="numeric");
    testCase.verifyEqual(gfs.readSignatureFromSignatureFile(inputfile), expectedSignature);
end