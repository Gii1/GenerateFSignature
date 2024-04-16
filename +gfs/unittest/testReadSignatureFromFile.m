function tests = testReadSignatureFromFile()
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
    % Add parent to path
    testCase.applyFixture(matlab.unittest.fixtures.PathFixture("../../"))
end

% Input is path to a script file
function testScriptFile(testCase)
    testCase.verifyEmpty(gfs.readSignatureFromFile("testdataReadSignatureFromFile/scriptfile.m"));
end

% Input is path to a function file
function testFunctionFile(testCase)
    signature = gfs.FunctionSignature("functionfile", inputs=["var1"]);
    testCase.verifyEqual(gfs.readSignatureFromFile("testdataReadSignatureFromFile/functionfile.m"), signature);
end

% Input is path to a class file
function testClassFile(testCase)
    signature = gfs.FunctionSignature("classfile.classfunction", inputs=["var1"]);
    testCase.verifyEqual(gfs.readSignatureFromFile("testdataReadSignatureFromFile/classfile.m"), signature);
end

% Input is path to an invalid m-file
function testInvalidFile(testCase)
    testCase.verifyError(@() gfs.readSignatureFromFile("testdataReadSignatureFromFile/invalidfile.m"), "gfs:invalidfile");
end