function tests = testEncodeSignatureToJson()
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
    % Add parent to path
    testCase.applyFixture(matlab.unittest.fixtures.PathFixture("../"))

    % Load the function output from file
    % The file consists of JSON-snippets, which are splited by %-style
    % comments
    filetext = string(fileread("testdataEncodeSignatureToJson.txt"));
    % split text into seperate function, 
    jsontext = regexp(filetext, "%.*?\n", "split");
    % remove first entry and remove trailling whitespaces
    jsontext = strip(jsontext(2:end));
    testCase.TestData.jsontext = jsontext;
end

function testEmptyFunction(testCase)
    signature = FunctionSignature("emptyfunction");
    verifyEqual(testCase, encodeSignatureToJson(signature), testCase.TestData.jsontext(1));
end

function testFunctionWithInputs(testCase)
    signature = FunctionSignature("functionwithinputs", inputs=["var1", "var2"]);
    verifyEqual(testCase, encodeSignatureToJson(signature), testCase.TestData.jsontext(2));
end

function testFunctionWithOutputs(testCase)
    signature = FunctionSignature("functionwithoutputs", outputs=["var1", "var2"]);
    verifyEqual(testCase, encodeSignatureToJson(signature), testCase.TestData.jsontext(3));
end

function testFunctionWithInputAndOutput(testCase)
    signature = FunctionSignature("functionwithinputandoutput", inputs="var1", outputs="var2");
    verifyEqual(testCase, encodeSignatureToJson(signature), testCase.TestData.jsontext(4));
end