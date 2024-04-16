function tests = testEncodeSignatureToStruct()
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
    % Add parent to path
    testCase.applyFixture(matlab.unittest.fixtures.PathFixture("../../"))
end

function testFunctionWithInputs(testCase)
    signature = gfs.FunctionSignature("functionwithinputs", inputs=["var1", "var2"]);
    inputstruct(1) = struct("name", "var1", "type", "required", "kind", "");
    inputstruct(2) = struct("name", "var2", "type", "required", "kind", "");
    functionstruct = struct("inputs", inputstruct);
    filestruct = struct("functionwithinputs", functionstruct);
    verifyEqual(testCase, gfs.encodeSignatureToStruct(signature), filestruct);
end

function testFunctionWithOutputs(testCase)
    signature = gfs.FunctionSignature("functionwithoutputs", outputs=["var1", "var2"]);
    outputstruct(1) = struct("name", "var1", "type", "required", "kind", "");
    outputstruct(2) = struct("name", "var2", "type", "required", "kind", "");
    functionstruct = struct("outputs", outputstruct);
    filestruct = struct("functionwithoutputs", functionstruct);
    verifyEqual(testCase, gfs.encodeSignatureToStruct(signature), filestruct);
end