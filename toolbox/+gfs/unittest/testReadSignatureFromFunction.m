function tests = testReadSignatureFromFunction
    tests = functiontests(localfunctions);
end

% Input is a function without input or output arguments
function testEmptyFunction(testCase)
    functionnode = mtree("testdata/testReadSignatureFromFunction/emptyfunction.m", "-file").root;
    testCase.verifyEmpty(gfs.readSignatureFromFunction(functionnode));
end

% Input is a function with 2 input arguments
function testFunctionWithInput(testCase)
    functionnode = mtree("testdata/testReadSignatureFromFunction/functionwithinputs.m", "-file").root;
    signature = gfs.FunctionSignature("functionwithinputs");
    signature.addInputs(["var1", "var2"]);
    testCase.verifyEqual(gfs.readSignatureFromFunction(functionnode), signature);
end

% Input is a function with 2 output arguments
function testFunctionWithOutputs(testCase)
    functionnode = mtree("testdata/testReadSignatureFromFunction/functionwithoutputs.m", "-file").root;
    signature = gfs.FunctionSignature("functionwithoutputs");
    signature.addOutputs(["var1", "var2"]);
    testCase.verifyEqual(gfs.readSignatureFromFunction(functionnode), signature);
end