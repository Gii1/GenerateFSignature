function tests = testReadSignatureFromFunction
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
    % Add parent to path
    testCase.applyFixture(matlab.unittest.fixtures.PathFixture("../"))

    % Load test functions from file
    filetext = string(fileread("testdataReadSignatureFromFunction.txt"));
    % split text into seperate function 
    functiontext = regexp(filetext, "\n(?=function)", "split");
    % first entry are just comments, can be excluded
    functiontext = functiontext(2:end);    
    testCase.TestData.functiontext = functiontext;
end

function testEmptyFunction(testCase)
    % Test1: Empty function
    node1 = mtree(testCase.TestData.functiontext(1)).root;
    sign1 = FunctionSignature("function1");
    testCase.verifyEqual(readSignatureFromFunction(node1), sign1);
end

function testFunctionWithInput(testCase)
    % Test2: Function with inputs
    node2 = mtree(testCase.TestData.functiontext(2)).root;
    sign2 = FunctionSignature("function2", input=["var1", "var2"]);
    testCase.verifyEqual(readSignatureFromFunction(node2), sign2);
end

function testFunctionWithOutputs(testCase)
    % Test3: Function with outputs
    node3 = mtree(testCase.TestData.functiontext(3)).root;
    sign3 = FunctionSignature("function3", output=["var1", "var2"]);
    testCase.verifyEqual(readSignatureFromFunction(node3), sign3);
end