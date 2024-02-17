# frozen_string_literal: true

require_relative "minis_ast"

module MinisRb
  module MEvaluators
    def self.evaluate_program(program)
      environment = {}
      program.functions.each do |function|
        environment[function.name] = function
      end
      result = nil
      program.bodies.each do |body|
        result = evaluate(body, environment)
      end
      result
    end

    def self.evaluate(e, env)
      if e.is_a? MBinExpr
        op = e.op
        case op
        when "+", "-", "*", "/"
          evaluate_math_expr(e, env)
        when "<", "<=", ">", ">=", "==", "!="
          evaluate_comp_expr(e, env)
        end
      elsif e.is_a? MSeq
        result = nil
        e.bodies.each do |body|
          result = evaluate(body, env)
        end
        result
      elsif e.is_a? MWhile
        condition = evaluate(e.condition, env)
        while condition != false
          e.bodies.each do |body|
            evaluate(body, env)
          end
          condition = evaluate(e.condition, env)
        end
        nil
      elsif e.is_a? MIf
        condition = evaluate(e.condition, env)
        result = nil
        if condition
          result = evaluate(e.then_clause, env)
        elsif e.else_clause
          result = evaluate(e.else_clause, env)
        end
        result
      elsif e.is_a? MAssignment
        env[e.name] = evaluate(e.expression, env)
        env[e.name]
      elsif e.is_a? MIdent
        env[e.name]
      elsif e.is_a? MCall
        func = env[e.name]
        args = e.args.map { |arg| evaluate(arg, env) }
        new_environment = env.clone
        args.each_with_index do |arg, i|
          new_environment[func.params[i]] = arg
        end
        evaluate(func.body, new_environment)
      elsif e.is_a? MInt
        e.value
      else
        raise "Unknown expression type: #{e.class} #{e.inspect}"
      end
    end

    def self.evaluate_math_expr(e, env)
      case e.op
      when "+"
        evaluate(e.lhs, env) + evaluate(e.rhs, env)
      when "-"
        evaluate(e.lhs, env) - evaluate(e.rhs, env)
      when "*"
        evaluate(e.lhs, env) * evaluate(e.rhs, env)
      when "/"
        evaluate(e.lhs, env) / evaluate(e.rhs, env)
      end
    end

    def self.evaluate_comp_expr(e, env)
      case e.op
      when "<"
        evaluate(e.lhs, env) < evaluate(e.rhs, env)
      when "<="
        evaluate(e.lhs, env) <= evaluate(e.rhs, env)
      when ">"
        evaluate(e.lhs, env) > evaluate(e.rhs, env)
      when ">="
        evaluate(e.lhs, env) >= evaluate(e.rhs, env)
      when "=="
        evaluate(e.lhs, env) == evaluate(e.rhs, env)
      when "!="
        evaluate(e.lhs, env) != evaluate(e.rhs, env)
      end
    end
  end
end
