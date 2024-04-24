function tests = testReadSignatureFromFunction
    tests = functiontests(localfunctions);
end

% Input is a function without input or output arguments
function testEmptyFunction(testCase)
    functionnode = mtree("testdataReadSignatureFromFunction/emptyfunction.m", "-file").root;
    testCase.verifyEmpty(gfs.readSignatureFromFunction(functionnode));
end

% Input is a function with 2 input arguments
function testFunctionWithInput(testCase)
    functionnode = mtree("testdataReadSignatureFromFunction/functionwithinputs.m", "-file").root;
    signature = gfs.FunctionSignature("functionwithinputs", input=["var1", "var2"]);
    testCase.verifyEqual(gfs.readSignatureFromFunction(functionnode), signature);
end

% Input is a function with 2 output arguments
function testFunctionWithOutputs(testCase)
    functionnode = mtree("testdataReadSignatureFromFunction/functionwithoutputs.m", "-file").root;
    signature = gfs.FunctionSignature("functionwithoutputs", output=["var1", "var2"]);
    testCase.verifyEqual(gfs.readSignatureFromFunction(functionnode), signature);
end