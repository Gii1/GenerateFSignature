function tests = testReadSignatureFromClass
    tests = functiontests(localfunctions);
end

% Input is class without any functions
function testEmptyClass(testCase)
    classnode = mtree("testdata/testReadSignatureFromClass/emptyclass.m", "-file").root;
    testCase.verifyEmpty(gfs.readSignatureFromClass(classnode));
end

% Input is class with 2 functions
function testClassWithFunctions(testCase)
    classnode = mtree("testdata/testReadSignatureFromClass/classwithfunctions.m", "-file").root;
    signature(1) = gfs.FunctionSignature("classwithfunctions.function1");
    signature(1).addInputs("var1");
    signature(2) = gfs.FunctionSignature("classwithfunctions.function2");
    signature(2).addInputs("var1");
    testCase.verifyEqual(gfs.readSignatureFromClass(classnode), signature);
end

% Input is class with a superclass
function testClassWithSuperClass(testCase)
    classnode = mtree("testdata/testReadSignatureFromClass/classwithsuperclass.m", "-file").root;
    signature = gfs.FunctionSignature("classwithsuperclass.function1");
    signature.addInputs("var1");
    testCase.verifyEqual(gfs.readSignatureFromClass(classnode), signature);
end