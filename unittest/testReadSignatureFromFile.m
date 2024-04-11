function tests = testReadSignatureFromFile()
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
    % Add parent to path
    testCase.applyFixture(matlab.unittest.fixtures.PathFixture("../"))
end

function testScriptFile(testCase)
    testCase.verifyEmpty(readSignatureFromFile("testdataReadSignatureFromFile/scriptfile.m"));
end

function testFunctionFile(testCase)
    signature = FunctionSignature("functionfile");
    testCase.verifyEqual(readSignatureFromFile("testdataReadSignatureFromFile/functionfile.m"), signature);
end

function testClassFile(testCase)
    signature = FunctionSignature("classfile.classfunction");
    testCase.verifyEqual(readSignatureFromFile("testdataReadSignatureFromFile/classfile.m"), signature);
end
