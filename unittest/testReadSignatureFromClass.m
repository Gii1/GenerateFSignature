import gfs.*

% Load test functions from file
filetext = string(fileread("testclass.txt"));
% split text into seperate function, 
classtext = regexp(filetext, "\n(?=classdef)", "split");
% first entry are just comments, can be excluded
classtext = classtext(2:end);

% Test 1: Empty class
node1 = mtree(classtext(1)).root;
assert(isempty(readSignatureFromClass(node1)));

% Test 2: Class with 2 functions
node2 = mtree(classtext(2)).root;
sign2(1) = FunctionSignature("class2.function1");
sign2(2) = FunctionSignature("class2.function2");
assert(all(isequal(sign2, readSignatureFromClass(node2))));