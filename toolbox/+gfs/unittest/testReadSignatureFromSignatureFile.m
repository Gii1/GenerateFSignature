function tests = testReadSignatureFromSignatureFile
    tests = functiontests(localfunctions);
end

% test function signature with 2 input variables
function testFunctionWithInputs(testCase)
    inputfile = "testdata/testReadSignatureFromSignatureFile/functionwithinputs.json";
    expected = gfs.FunctionSignature("function");
    expected.addInputs(["var1", "var2"], kind="required", type="numeric");
    actual = gfs.readSignatureFromSignatureFile(inputfile);
    testCase.verifyEqual(actual, expected);
end

% test function signature with 2 output variables
function testFunctionWithOutputs(testCase)
    inputfile = "testdata/testReadSignatureFromSignatureFile/functionwithoutputs.json";
    expected = gfs.FunctionSignature("function");
    expected.addOutputs(["var1", "var2"], type="numeric");
    actual = gfs.readSignatureFromSignatureFile(inputfile);
    testCase.verifyEqual(actual, expected);
end

% test signature file with multiple function signatures
function testMultipleFunction(testCase)
    inputfile = "testdata/testReadSignatureFromSignatureFile/multiplefunctions.json";
    expected(1) = gfs.FunctionSignature("function1");
    expected(1).addInputs("var1", kind="required", type="numeric");
    expected(2) = gfs.FunctionSignature("function2");
    expected(2).addInputs("var1", kind="required", type="numeric");
    actual = gfs.readSignatureFromSignatureFile(inputfile);
    testCase.verifyEqual(actual, expected);
end

% test class function with dot in name (invalid field)
function testClassFunction(testCase)
    inputfile = "testdata/testReadSignatureFromSignatureFile/classfunction.json";
    expected = gfs.FunctionSignature("class.function");
    expected.addInputs("var1", kind="required");
    actual = gfs.readSignatureFromSignatureFile(inputfile);
    testCase.verifyEqual(actual, expected);
end

% test for empty function signature
function testEmptyFunctionSignature(testCase)
    inputfile = "testdata/testReadSignatureFromSignatureFile/emptyfunction.json";
    actual = gfs.readSignatureFromSignatureFile(inputfile);
    testCase.verifyEmpty(actual);
end