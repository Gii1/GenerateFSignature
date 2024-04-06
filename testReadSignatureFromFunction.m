% Load test functions from file
tree = mtree("testfunction.m");
root = tree.root;

% Test1: Empty function
node1 = root.Next;
sign1 = FunctionSignature("function1");
assert(node1 == readSignatureFromFunction(node1));

% Test2: Function with inputs
node2 = root.Next;
sign2 = FunctionSignature("function2", input=["var1", "var2"]);
assert(node2 == readSignatureFromFunction(node2));

% Test3: Function with outputs
node3 = root.Next;
sign3 = FunctionSignature("function3", output=["var1", "var2"]);
assert(node3 == readSignatureFromFunction(node3));