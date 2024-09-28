function tests = testReadSignatureFromFunction
    tests = functiontests(localfunctions);
end

% Input is a function without input or output arguments
function testEmptyFunction(testCase)
    functionnode = mtree("testdata/testReadSignatureFromFunction/emptyfunction.m", "-file").root;
    actual = gfs.readSignatureFromFunction(functionnode);
    testCase.verifyEmpty(actual);
end

% Input is a function with 2 input arguments
function testFunctionWithInput(testCase)
    functionnode = mtree("testdata/testReadSignatureFromFunction/functionwithinputs.m", "-file").root;
    expected = gfs.FunctionSignature("functionwithinputs");
    expected.addInputs(["var1", "var2"]);
    actual = gfs.readSignatureFromFunction(functionnode);
    testCase.verifyEqual(actual, expected);
end

% Input is a function with 2 output arguments
function testFunctionWithOutputs(testCase)
    functionnode = mtree("testdata/testReadSignatureFromFunction/functionwithoutputs.m", "-file").root;
    expected = gfs.FunctionSignature("functionwithoutputs");
    expected.addOutputs(["var1", "var2"]);
    actual = gfs.readSignatureFromFunction(functionnode);
    testCase.verifyEqual(actual, expected);
end