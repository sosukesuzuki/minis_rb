# frozen_string_literal: true

RSpec.describe MinisRb::MEvaluators do
  describe "数学の演算" do
    it "1と2の和が3になる" do
      expr = MinisRb::MASTBuilders.add(
        MinisRb::MASTBuilders.int(1),
        MinisRb::MASTBuilders.int(2)
      )
      expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(3)
    end

    it "1と2の差が-1になる" do
      expr = MinisRb::MASTBuilders.sub(
        MinisRb::MASTBuilders.int(1),
        MinisRb::MASTBuilders.int(2)
      )
      expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(-1)
    end

    it "2と3の積が6になる" do
      expr = MinisRb::MASTBuilders.mul(
        MinisRb::MASTBuilders.int(2),
        MinisRb::MASTBuilders.int(3)
      )
      expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(6)
    end

    it "6と3の商が2になる" do
      expr = MinisRb::MASTBuilders.div(
        MinisRb::MASTBuilders.int(6),
        MinisRb::MASTBuilders.int(3)
      )
      expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(2)
    end
  end

  describe "比較演算" do
    describe "小なり" do
      it "1<2がtrue" do
        expr = MinisRb::MASTBuilders.lt(
          MinisRb::MASTBuilders.int(1),
          MinisRb::MASTBuilders.int(2)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
      end

      it "2<1がfalse" do
        expr = MinisRb::MASTBuilders.lt(
          MinisRb::MASTBuilders.int(2),
          MinisRb::MASTBuilders.int(1)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(false)
      end
    end

    describe "大なり" do
      it "2>1がtrue" do
        expr = MinisRb::MASTBuilders.gt(
          MinisRb::MASTBuilders.int(2),
          MinisRb::MASTBuilders.int(1)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
      end

      it "1>2がfalse" do
        expr = MinisRb::MASTBuilders.gt(
          MinisRb::MASTBuilders.int(1),
          MinisRb::MASTBuilders.int(2)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(false)
      end
    end

    describe "小なりイコール" do
      it "1<=2がtrue" do
        expr = MinisRb::MASTBuilders.lte(
          MinisRb::MASTBuilders.int(1),
          MinisRb::MASTBuilders.int(2)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
      end

      it "2<=1がfalse" do
        expr = MinisRb::MASTBuilders.lte(
          MinisRb::MASTBuilders.int(2),
          MinisRb::MASTBuilders.int(1)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(false)
      end

      it "2<=2がtrue" do
        expr = MinisRb::MASTBuilders.lte(
          MinisRb::MASTBuilders.int(2),
          MinisRb::MASTBuilders.int(2)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
      end
    end

    describe "大なりイコール" do
      it "2>=1がtrue" do
        expr = MinisRb::MASTBuilders.gte(
          MinisRb::MASTBuilders.int(2),
          MinisRb::MASTBuilders.int(1)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
      end

      it "1>=2がfalse" do
        expr = MinisRb::MASTBuilders.gte(
          MinisRb::MASTBuilders.int(1),
          MinisRb::MASTBuilders.int(2)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(false)
      end

      it "2>=2がtrue" do
        expr = MinisRb::MASTBuilders.gte(
          MinisRb::MASTBuilders.int(2),
          MinisRb::MASTBuilders.int(2)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
      end
    end

    describe "イコール" do
      it "1==1がtrue" do
        expr = MinisRb::MASTBuilders.eq(
          MinisRb::MASTBuilders.int(1),
          MinisRb::MASTBuilders.int(1)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
      end

      it "1==2がfalse" do
        expr = MinisRb::MASTBuilders.eq(
          MinisRb::MASTBuilders.int(1),
          MinisRb::MASTBuilders.int(2)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(false)
      end
    end

    describe "ノットイコール" do
      it "1!=2がtrue" do
        expr = MinisRb::MASTBuilders.neq(
          MinisRb::MASTBuilders.int(1),
          MinisRb::MASTBuilders.int(2)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
      end

      it "1!=1がfalse" do
        expr = MinisRb::MASTBuilders.neq(
          MinisRb::MASTBuilders.int(1),
          MinisRb::MASTBuilders.int(1)
        )
        expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(false)
      end
    end
  end

  describe "連接" do
    it "もっとも右の式の評価結果が全体の評価結果になる" do
      expr = MinisRb::MASTBuilders.seq(
        MinisRb::MASTBuilders.int(1),
        MinisRb::MASTBuilders.int(2),
        MinisRb::MASTBuilders.int(3)
      )
      expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(3)
    end
  end

  describe "識別子" do
    it "環境に入っている値が結果になる" do
      expr = MinisRb::MASTBuilders.id("x")
      expect(MinisRb::MEvaluators.evaluate(expr, { "x" => 1 })).to eq(1)
    end
  end

  describe "代入" do
    it "代入された値を参照できる" do
      expr = MinisRb::MASTBuilders.program(
        [],
        MinisRb::MASTBuilders.assign("x", MinisRb::MASTBuilders.int(0)),
        MinisRb::MASTBuilders.assign("x", MinisRb::MASTBuilders.int(1)),
        MinisRb::MASTBuilders.id("x")
      )
      expect(MinisRb::MEvaluators.evaluate_program(expr)).to eq(1)
    end

    it "代入した値が結果になる" do
      expr = MinisRb::MASTBuilders.assign("x", MinisRb::MASTBuilders.int(1))
      expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(1)
    end
  end

  describe "if" do
    it "条件がtrueならthen_clauseが結果になる" do
      # if (1 == 1) { 2 } else { 3 } のような式
      expr = MinisRb::MASTBuilders.if(
        MinisRb::MASTBuilders.eq(MinisRb::MASTBuilders.int(1), MinisRb::MASTBuilders.int(1)),
        MinisRb::MASTBuilders.int(2),
        MinisRb::MASTBuilders.int(3)
      )
      expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(2)
    end

    it "条件がfalseならelse_clauseが結果になる" do
      # if (1 == 2) { 2 } else { 3 } のような式
      expr = MinisRb::MASTBuilders.if(
        MinisRb::MASTBuilders.eq(MinisRb::MASTBuilders.int(1), MinisRb::MASTBuilders.int(2)),
        MinisRb::MASTBuilders.int(2),
        MinisRb::MASTBuilders.int(3)
      )
      expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(3)
    end

    it "条件がfalseでかつelse_clauseがない場合はnilが結果になる" do
      # if (1 == 2) { 2 } のような式
      expr = MinisRb::MASTBuilders.if(
        MinisRb::MASTBuilders.eq(MinisRb::MASTBuilders.int(1), MinisRb::MASTBuilders.int(2)),
        MinisRb::MASTBuilders.int(2),
        nil
      )
      expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(nil)
    end
  end

  describe "while" do
    it "結果がnilになる" do
      # while (1 == 2) { 2 } のような式
      expr = MinisRb::MASTBuilders.while(
        MinisRb::MASTBuilders.eq(MinisRb::MASTBuilders.int(1), MinisRb::MASTBuilders.int(2)),
        MinisRb::MASTBuilders.int(2)
      )
      expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(nil)
    end

    it "bodiesが繰り返される" do
      # x = 0; while (x < 3) { x = x + 1 }; x; のような式
      expr = MinisRb::MASTBuilders.program(
        [],
        MinisRb::MASTBuilders.assign("x", MinisRb::MASTBuilders.int(0)),
        MinisRb::MASTBuilders.while(
          MinisRb::MASTBuilders.lt(MinisRb::MASTBuilders.id("x"), MinisRb::MASTBuilders.int(3)),
          MinisRb::MASTBuilders.assign("x",
                                       MinisRb::MASTBuilders.add(MinisRb::MASTBuilders.id("x"),
                                                                 MinisRb::MASTBuilders.int(1)))
        ),
        MinisRb::MASTBuilders.id("x")
      )
      expect(MinisRb::MEvaluators.evaluate_program(expr)).to eq(3)
    end
  end

  describe "関数呼び出し" do
    it "programに渡した関数を呼び出し、結果が返される" do
      # def f(x) { x + 1 }; f(1) のような式
      program = MinisRb::MASTBuilders.program(
        [
          MinisRb::MASTBuilders.function("f", ["x"], MinisRb::MASTBuilders.add(MinisRb::MASTBuilders.id("x"), MinisRb::MASTBuilders.int(1)))
        ],
        MinisRb::MASTBuilders.call("f", MinisRb::MASTBuilders.int(1))
      )
      expect(MinisRb::MEvaluators.evaluate_program(program)).to eq(2)
    end
  end
end
