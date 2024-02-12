# frozen_string_literal: true

class MAST
  attr_reader :type

  def initialize(type)
    @type = type
  end
end

class MExpr < MAST
  def initialize(type)
    super(type)
  end
end

class MProgram < MAST
  attr_reader :functions, :bodies

  def initialize(functions, *bodies)
    super("MProgram")
    @functions = functions
    @bodies = bodies
  end
end

class MFunc < MAST
  attr_reader :name, :params, :body

  def initialize(name, params, body)
    super("MFunc")
    @name = name
    @params = params
    @body = body
  end
end

class MBinExpr < MExpr
  attr_reader :op, :lhs, :rhs

  def initialize(op, lhs, rhs)
    super("MBinExpr")
    @op = op
    @lhs = lhs
    @rhs = rhs
  end
end

class MIf < MExpr
  attr_reader :condition, :then_clause, :else_clause

  def initialize(condition, then_clause, else_clause)
    super("MIf")
    @condition = condition
    @then_clause = then_clause
    @else_clause = else_clause
  end
end

class MSeq < MExpr
  attr_reader :bodies

  def initialize(*bodies)
    super("MSeq")
    @bodies = bodies
  end
end

class MWhile < MExpr
  attr_reader :condition, :bodies

  def initialize(condition, *bodies)
    super("MWhile")
    @condition = condition
    @bodies = bodies
  end
end

class MCall < MExpr
  attr_reader :name, :args

  def initialize(name, *args)
    super("MCall")
    @name = name
    @args = args
  end
end

class MAssignment < MExpr
  attr_reader :name, :expression

  def initialize(name, expression)
    super("MAssignment")
    @name = name
    @expression = expression
  end
end

class MInt < MExpr
  attr_reader :value

  def initialize(value)
    super("MInt")
    @value = value
  end
end

class MIdent < MExpr
  attr_reader :name

  def initialize(name)
    super("MIdent")
    @name = name
  end
end

module MinisRb
  module MASTBuilders
    def self.program(functions, *bodies)
      MProgram.new(functions, *bodies)
    end

    def self.function(name, params, body)
      MFunc.new(name, params, body)
    end

    def self.add(a, b)
      MBinExpr.new("+", a, b)
    end

    def self.sub(a, b)
      MBinExpr.new("-", a, b)
    end

    def self.mul(a, b)
      MBinExpr.new("*", a, b)
    end

    def self.div(a, b)
      MBinExpr.new("/", a, b)
    end

    def self.lt(a, b)
      MBinExpr.new("<", a, b)
    end

    def self.gt(a, b)
      MBinExpr.new(">", a, b)
    end

    def self.lte(a, b)
      MBinExpr.new("<=", a, b)
    end

    def self.gte(a, b)
      MBinExpr.new(">=", a, b)
    end

    def self.eq(a, b)
      MBinExpr.new("==", a, b)
    end

    def self.neq(a, b)
      MBinExpr.new("!=", a, b)
    end

    def self.int(value)
      MInt.new(value)
    end

    def self.assign(name, value)
      MAssignment.new(name, value)
    end

    def self.id(name)
      MIdent.new(name)
    end

    def self.seq(*expressions)
      MSeq.new(*expressions)
    end

    def self.call(name, *args)
      MCall.new(name, *args)
    end

    def self.while(condition, *bodies)
      MWhile.new(condition, *bodies)
    end

    def self.if(condition, then_clause, else_clause)
      MIf.new(condition, then_clause, else_clause)
    end
  end
end
