function tests = testReadSignatureFromClass
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
    % Add parent to path
    testCase.applyFixture(matlab.unittest.fixtures.PathFixture("../"))

    % Load test functions from file
    filetext = string(fileread("testdataReadSignatureFromClass.txt"));
    % split text into seperate function, 
    classtext = regexp(filetext, "\n(?=classdef)", "split");
    % first entry are just comments, can be excluded
    classtext = classtext(2:end);
    testCase.TestData.classtext = classtext;
end

function testEmptyClass(testCase)
    % Test 1: Empty class
    node1 = mtree(testCase.TestData.classtext(1)).root;
    testCase.verifyEmpty(readSignatureFromClass(node1));
end

function testClassWithFunctions(testCase)
    % Test 2: Class with 2 functions
    node2 = mtree(testCase.TestData.classtext(2)).root;
    sign2(1) = FunctionSignature("class2.function1");
    sign2(2) = FunctionSignature("class2.function2");
    testCase.verifyEqual(sign2, readSignatureFromClass(node2));
end