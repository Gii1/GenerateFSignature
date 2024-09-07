classdef FunctionSignature < handle
    properties
        name (1,1) string;
        inputs struct = struct(name=cell(1, 0), kind=cell(1, 0), type=cell(1, 0));
        outputs struct = struct(name=cell(1, 0), type=cell(1, 0));
    end

    methods
        function sign = FunctionSignature(name)
            arguments
                name (1, 1) string = "";
            end

            sign.name = name;
        end

        function addInputs(signature, name, param)
            arguments
                signature;
                name string;
                param.kind = "required";
                param.type = "null";
            end
            
            signature.inputs = [signature.inputs, struct(name=num2cell(name), kind=num2cell(param.kind), type=num2cell(param.type))];
        end

        function addOutputs(signature, name, param)
            arguments
                signature;
                name string;
                param.type = "null";
            end

            signature.outputs = [signature.outputs, struct(name=num2cell(name), type=num2cell(param.type))];
        end

        function disp(signature)
            disp("FunctionSignature with the following structure:")
            disp(gfs.encodeSignatureToJson(signature))
        end
    end
end