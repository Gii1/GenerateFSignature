function tests = testReadSignatureFromClass
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
    % Load test functions from file
    filetext = string(fileread("testdataReadSignatureFromClass.txt"));
    % split text into seperate function, 
    classtext = regexp(filetext, "%.*?\n", "split");
    classtext = classtext(2:end);
    testCase.TestData.classtext = classtext;
end

% Input is class without any functions
function testEmptyClass(testCase)
    classnode = mtree(testCase.TestData.classtext(1)).root;
    testCase.verifyEmpty(gfs.readSignatureFromClass(classnode));
end

% Input is class with 2 functions
function testClassWithFunctions(testCase)
    classnode = mtree(testCase.TestData.classtext(2)).root;
    signature(1) = gfs.FunctionSignature("class2.function1", inputs=["var1"]);
    signature(2) = gfs.FunctionSignature("class2.function2", inputs=["var1"]);
    testCase.verifyEqual(gfs.readSignatureFromClass(classnode), signature);
end