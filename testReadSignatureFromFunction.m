% Load test functions from file
filetext = string(fileread("testfunction.txt"));
% split text into seperate function, 
functiontext = regexp(filetext, "\n(?=function)", "split");
% first entry are just comments, can be excluded
functiontext = functiontext(2:end);

% Test1: Empty function
node1 = mtree(functiontext(1), newline).root;
sign1 = FunctionSignature("function1");
assert(isequal(node1, readSignatureFromFunction(node1)));

% Test2: Function with inputs
node2 = mtree(functiontext(2), newline).root;
sign2 = FunctionSignature("function2", input=["var1", "var2"]);
assert(isequal(node2, readSignatureFromFunction(node2)));

% Test3: Function with outputs
node3 = mtree(functiontext(3), newline).root;
sign3 = FunctionSignature("function3", output=["var1", "var2"]);
assert(isequal(node3, readSignatureFromFunction(node3)));