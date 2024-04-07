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
            sign.inputs = struct(name=num2cell(param.inputs));
            sign.outputs = struct(name=num2cell(param.outputs));
        end
    end
end