function tests = testReadSignatureFromFile()
    tests = functiontests(localfunctions);
end

% Input is path to a script file
function testScriptFile(testCase)
    testCase.verifyEmpty(gfs.readSignatureFromFile("testdata/testReadSignatureFromFile/scriptfile.m"));
end

% Input is path to a function file
function testFunctionFile(testCase)
    signature = gfs.FunctionSignature("functionfile");
    signature.addInputs("var1");
    testCase.verifyEqual(gfs.readSignatureFromFile("testdata/testReadSignatureFromFile/functionfile.m"), signature);
end

% Input is path to a class file
function testClassFile(testCase)
    signature = gfs.FunctionSignature("classfile.classfunction");
    signature.addInputs("var1");
    testCase.verifyEqual(gfs.readSignatureFromFile("testdata/testReadSignatureFromFile/classfile.m"), signature);
end

% Input is path to an invalid m-file
function testInvalidFile(testCase)
    testCase.verifyError(@() gfs.readSignatureFromFile("testdata/testReadSignatureFromFile/invalidfile.m"), "gfs:invalidfile");
end