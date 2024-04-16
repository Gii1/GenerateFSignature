function tests = testReadSignatureFromFunction
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
    % Add parent to path
    testCase.applyFixture(matlab.unittest.fixtures.PathFixture("../../"))

    % Load test functions from file
    filetext = string(fileread("testdataReadSignatureFromFunction.txt"));
    % split text into seperate function 
    functiontext = regexp(filetext, "%.*?\n", "split");
    % remove first entry which is empty
    functiontext = functiontext(2:end);
    testCase.TestData.functiontext = functiontext;
end

% Input is a function without input or output arguments
function testEmptyFunction(testCase)
    functionnode = mtree(testCase.TestData.functiontext(1)).root;
    testCase.verifyEmpty(gfs.readSignatureFromFunction(functionnode));
end

% Input is a function with 2 input arguments
function testFunctionWithInput(testCase)
    functionnode = mtree(testCase.TestData.functiontext(2)).root;
    signature = gfs.FunctionSignature("function2", input=["var1", "var2"]);
    testCase.verifyEqual(gfs.readSignatureFromFunction(functionnode), signature);
end

% Input is a function with 2 output arguments
function testFunctionWithOutputs(testCase)
    functionnode = mtree(testCase.TestData.functiontext(3)).root;
    signature = gfs.FunctionSignature("function3", output=["var1", "var2"]);
    testCase.verifyEqual(gfs.readSignatureFromFunction(functionnode), signature);
end