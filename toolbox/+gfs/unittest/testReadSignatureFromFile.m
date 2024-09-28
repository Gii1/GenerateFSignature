function tests = testReadSignatureFromFile()
    tests = functiontests(localfunctions);
end

% Input is path to a script file
function testScriptFile(testCase)
    actual = gfs.readSignatureFromFile("testdata/testReadSignatureFromFile/scriptfile.m");
    testCase.verifyEmpty(actual);
end

% Input is path to a function file
function testFunctionFile(testCase)
    expected = gfs.FunctionSignature("functionfile");
    expected.addInputs("var1");
    actual = gfs.readSignatureFromFile("testdata/testReadSignatureFromFile/functionfile.m");
    testCase.verifyEqual(actual, expected);
end

% Input is path to a class file
function testClassFile(testCase)
    exected = gfs.FunctionSignature("classfile.classfunction");
    exected.addInputs("var1", type="classfile");
    actual = gfs.readSignatureFromFile("testdata/testReadSignatureFromFile/classfile.m");
    testCase.verifyEqual(actual, exected);
end

% Input is path to an invalid m-file
function testInvalidFile(testCase)
    testCase.verifyError(@() gfs.readSignatureFromFile("testdata/testReadSignatureFromFile/invalidfile.m"), "gfs:invalidfile");
end