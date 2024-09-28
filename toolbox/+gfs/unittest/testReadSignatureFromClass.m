function tests = testReadSignatureFromClass
    tests = functiontests(localfunctions);
end

% Input is class without any functions
function testEmptyClass(testCase)
    classnode = mtree("testdata/testReadSignatureFromClass/emptyclass.m", "-file").root;
    actual = gfs.readSignatureFromClass(classnode);
    testCase.verifyEmpty(actual);
end

% Input is class with 2 functions
function testClassWithFunctions(testCase)
    classnode = mtree("testdata/testReadSignatureFromClass/classwithfunctions.m", "-file").root;
    expected(1) = gfs.FunctionSignature("classwithfunctions.function1");
    expected(1).addInputs("var1", type="classwithfunctions");
    expected(2) = gfs.FunctionSignature("classwithfunctions.function2");
    expected(2).addInputs("var1", type="classwithfunctions");
    actual = gfs.readSignatureFromClass(classnode);
    testCase.verifyEqual(actual, expected);
end

% Input is class with a superclass
function testClassWithSuperClass(testCase)
    classnode = mtree("testdata/testReadSignatureFromClass/classwithsuperclass.m", "-file").root;
    expected = gfs.FunctionSignature("classwithsuperclass.function1");
    expected.addInputs("var1", type="classwithsuperclass");
    actual = gfs.readSignatureFromClass(classnode);
    testCase.verifyEqual(actual, expected);
end

% Input is class with property
function testClassWithProperty(testCase)
    classnode = mtree("testdata/testReadSignatureFromClass/classwithproperty.m", "-file").root;
    expected = gfs.FunctionSignature("classwithproperty.function1");
    expected.addInputs("var1", type="classwithproperty");
    actual = gfs.readSignatureFromClass(classnode);
    testCase.verifyEqual(actual, expected);    
end

% Test class with multiple method blocks
function testClassWithMultipleMethodBlocks(testCase)
    classnode = mtree("testdata/testReadSignatureFromClass/classwithmultiplemethodblocks.m", "-file").root;
    expected(1) = gfs.FunctionSignature("classwithmultiplemethodblocks.function1");
    expected(1).addInputs("var1", type="classwithmultiplemethodblocks");
    expected(2) = gfs.FunctionSignature("classwithmultiplemethodblocks.function2");
    expected(2).addInputs("var1", type="classwithmultiplemethodblocks");
    actual = gfs.readSignatureFromClass(classnode);
    testCase.verifyEqual(actual, expected);        
end

% Test class with constructor
function testClassWithConstructor(testCase)
    classnode = mtree("testdata/testReadSignatureFromClass/classwithconstructor.m", "-file").root;
    expected = gfs.FunctionSignature("classwithconstructor.classwithconstructor");
    expected.addOutputs("var1", type="classwithconstructor");
    actual = gfs.readSignatureFromClass(classnode);
    testCase.verifyEqual(actual, expected);
end