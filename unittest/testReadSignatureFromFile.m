function tests = testReadSignatureFromFile()
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
    % Add parent to path
    testCase.applyFixture(matlab.unittest.fixtures.PathFixture("../"))
end

% Input is path to a script file
function testScriptFile(testCase)
    testCase.verifyEmpty(readSignatureFromFile("testdataReadSignatureFromFile/scriptfile.m"));
end

% Input is path to a function file
function testFunctionFile(testCase)
    signature = FunctionSignature("functionfile");
    testCase.verifyEqual(readSignatureFromFile("testdataReadSignatureFromFile/functionfile.m"), signature);
end

% Input is path to a class file
function testClassFile(testCase)
    signature = FunctionSignature("classfile.classfunction");
    testCase.verifyEqual(readSignatureFromFile("testdataReadSignatureFromFile/classfile.m"), signature);
end
