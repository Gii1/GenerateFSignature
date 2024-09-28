function tests = testReadSignatureFromFolder()
    tests = functiontests(localfunctions);
end

% Input is path to a folder which contains a m-file
function testFolderWithMFile(testCase)
    exected = gfs.FunctionSignature("functionfile");
    exected.addInputs("var1");
    actual = gfs.readSignatureFromFolder("testdata/testReadSignatureFromFolder/folderWithMFile");
    testCase.verifyEqual(actual, exected);
end

% Input is path to a folder with a file which is not a m-file
function testFolderWithOtherFile(testCase)
    actual = gfs.readSignatureFromFolder("testdata/testReadSignatureFromFolder/folderWithOtherFile");
    testCase.verifyEmpty(actual);
end

% Input is path to a folder which contains a m-file which can not be
% parsed
function testFolderWithInvalidFile(testCase)
    testCase.verifyError(@() gfs.readSignatureFromFolder("testdata/testReadSignatureFromFolder/folderWithInvalidFile"), "gfs:invalidfile")
end