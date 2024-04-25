function tests = testReadSignatureFromFolder()
    tests = functiontests(localfunctions);
end

% Input is path to a folder which contains a m-file
function testFolderWithMFile(testCase)
    signature = gfs.FunctionSignature("functionfile");
    signature.addInputs("var1");
    testCase.verifyEqual(gfs.readSignatureFromFolder("testdataReadSignatureFromFolder/folderWithMFile"), signature);
end

% Input is path to a folder with a file which is not a m-file
function testFolderWithOtherFile(testCase)
    testCase.verifyEmpty(gfs.readSignatureFromFolder("testdataReadSignatureFromFolder/folderWithOtherFile"));
end

% Input is path to a folder which contains a m-file which can not be
% parsed
function testFolderWithInvalidFile(testCase)
    testCase.verifyError(@() gfs.readSignatureFromFolder("testdataReadSignatureFromFolder/folderWithInvalidFile"), "gfs:invalidfile")
end