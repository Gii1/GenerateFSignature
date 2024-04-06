classdef FunctionSignature
    properties
        name (1,1) string;
        inputs struct;
        outputs struct;
    end

    methods
        function sign = FunctionSignature(name, param)
            arguments
                name (1, 1) string;
                param.inputs = [];
                param.outputs = [];
            end

            sign.name = name;
            sign.inputs.name = param.inputs;
            sign.outputs.name = param.outputs;
        end
    end
end