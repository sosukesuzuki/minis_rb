# frozen_string_literal: true

require "json"

module MinisRb
  module MJsonEvaluator
    def self.evaluate_json_program(json_string)
      program = JSON.parse(json_string)
      environment = {}
      bodies = []
      functions = []
      program.each do |function_or_expression|
        if function_or_expression.is_a?(Hash) && function_or_expression["type"] == "def"
          functions.push(function_or_expression)
        else
          bodies.push(translate_to_ast(function_or_expression))
        end
      end
      functions.each do |function|
        environment[function["name"]] = MASTBuilders.function(
          function["name"],
          function["params"],
          translate_to_ast(function["body"])
        )
      end
      result = nil
      bodies.each do |body|
        result = MEvaluators.evaluate(body, environment)
      end
      result
    end

    def self.evaluate_json(json_string)
      json_object = JSON.parse(json_string)
      MEvaluators.evaluate(translate_to_ast(json_object), {})
    end

    def self.translate_to_ast(json_object)
      if json_object.is_a? Integer
        MASTBuilders.int(json_object)
      elsif json_object.is_a? Array
        MASTBuilders.array(*json_object.map { |item| translate_to_ast(item) })
      elsif json_object.is_a? Hash
        case json_object["type"]
        when "+"
          MASTBuilders.add(
            translate_to_ast(json_object["left"]),
            translate_to_ast(json_object["right"])
          )
        when "-"
          MASTBuilders.sub(
            translate_to_ast(json_object["left"]),
            translate_to_ast(json_object["right"])
          )
        when "*"
          MASTBuilders.mul(
            translate_to_ast(json_object["left"]),
            translate_to_ast(json_object["right"])
          )
        when "/"
          MASTBuilders.div(
            translate_to_ast(json_object["left"]),
            translate_to_ast(json_object["right"])
          )
        when "<"
          MASTBuilders.lt(
            translate_to_ast(json_object["left"]),
            translate_to_ast(json_object["right"])
          )
        when ">"
          MASTBuilders.gt(
            translate_to_ast(json_object["left"]),
            translate_to_ast(json_object["right"])
          )
        when "<="
          MASTBuilders.lte(
            translate_to_ast(json_object["left"]),
            translate_to_ast(json_object["right"])
          )
        when ">="
          MASTBuilders.gte(
            translate_to_ast(json_object["left"]),
            translate_to_ast(json_object["right"])
          )
        when "=="
          MASTBuilders.eq(
            translate_to_ast(json_object["left"]),
            translate_to_ast(json_object["right"])
          )
        when "!="
          MASTBuilders.neq(
            translate_to_ast(json_object["left"]),
            translate_to_ast(json_object["right"])
          )
        when "id"
          MASTBuilders.id(json_object["name"])
        when "assign"
          MASTBuilders.assign(
            json_object["name"],
            translate_to_ast(json_object["value"])
          )
        when "call"
          MASTBuilders.call(
            json_object["name"],
            *json_object["args"].map { |arg| translate_to_ast(arg) }
          )
        when "if"
          MASTBuilders.if(
            translate_to_ast(json_object["condition"]),
            translate_to_ast(json_object["then"]),
            translate_to_ast(json_object["else"])
          )
        when "while"
          MASTBuilders.while(
            translate_to_ast(json_object["condition"]),
            translate_to_ast(json_object["body"])
          )
        when "seq"
          MASTBuilders.seq(
            *json_object["expressions"].map { |expr| translate_to_ast(expr) }
          )
        when "index"
          MASTBuilders.index(
            translate_to_ast(json_object["array"]),
            translate_to_ast(json_object["index"])
          )
        else
          raise "Unknown AST type: #{json_object["type"]}"
        end
      end
    end
  end
end
