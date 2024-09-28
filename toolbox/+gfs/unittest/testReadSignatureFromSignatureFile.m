function tests = testReadSignatureFromSignatureFile
    tests = functiontests(localfunctions);
end

% test function signature with 2 input variables
function testFunctionWithInputs(testCase)
    inputfile = "testdata/testReadSignatureFromSignatureFile/functionwithinputs.json";
    expectedSignature = gfs.FunctionSignature("function");
    expectedSignature.addInputs(["var1", "var2"], kind="required", type="numeric");
    testCase.verifyEqual(gfs.readSignatureFromSignatureFile(inputfile), expectedSignature);
end

% test function signature with 2 output variables
function testFunctionWithOutputs(testCase)
    inputfile = "testdata/testReadSignatureFromSignatureFile/functionwithoutputs.json";
    expectedSignature = gfs.FunctionSignature("function");
    expectedSignature.addOutputs(["var1", "var2"], type="numeric");
    testCase.verifyEqual(gfs.readSignatureFromSignatureFile(inputfile), expectedSignature);
end

% test signature file with multiple function signatures
function testMultipleFunction(testCase)
    inputfile = "testdata/testReadSignatureFromSignatureFile/multiplefunctions.json";
    expectedSignature(1) = gfs.FunctionSignature("function1");
    expectedSignature(1).addInputs("var1", kind="required", type="numeric");
    expectedSignature(2) = gfs.FunctionSignature("function2");
    expectedSignature(2).addInputs("var1", kind="required", type="numeric");
    testCase.verifyEqual(gfs.readSignatureFromSignatureFile(inputfile), expectedSignature);
end

% test class function with dot in name (invalid field)
function testClassFunction(testCase)
    inputfile = "testdata/testReadSignatureFromSignatureFile/classfunction.json";
    expectedSignature = gfs.FunctionSignature("class.function");
    expectedSignature.addInputs("var1", kind="required");
    testCase.verifyEqual(gfs.readSignatureFromSignatureFile(inputfile), expectedSignature);
end

% test for empty function signature
function testEmptyFunctionSignature(testCase)
    inputfile = "testdata/testReadSignatureFromSignatureFile/emptyfunction.json";
    actual = gfs.readSignatureFromSignatureFile(inputfile);
    testCase.verifyEmpty(actual);
end