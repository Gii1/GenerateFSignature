function tests = testReadSignatureFromFolder()
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
    % Add parent to path
    testCase.applyFixture(matlab.unittest.fixtures.PathFixture("../../"))
end

% Input is path to an empty folder
function testEmptyFolder(testCase)
    testCase.verifyEmpty(gfs.readSignatureFromFolder("testdataReadSignatureFromFolder/emptyFolder"));
end

% Input is path to a folder which contains a m-file
function testFolderWithMFile(testCase)
    signature = gfs.FunctionSignature("functionfile");
    testCase.verifyEqual(gfs.readSignatureFromFolder("testdataReadSignatureFromFolder/folderWithMFile"), signature);
end

% Input is path to a folder with a file which is not a m-file
function testFolderWithOtherFile(testCase)
    testCase.verifyEmpty(gfs.readSignatureFromFolder("testdataReadSignatureFromFolder/folderWithOtherFile"));
end

% Input is path to a folder which contains a m-file which can not be
% parsed
function testFolderWithInvalidFile(testCase)
    testCase.verifyError(@() gfs.readSignatureFromFolder("testdataReadSignatureFromFolder/folderWithInvalidFile"), "generatesign:invalidfile")
end