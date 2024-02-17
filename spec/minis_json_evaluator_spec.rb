# frozen_string_literal: true

RSpec.describe MinisRb::MJsonEvaluator do
  describe "evaluate_json" do
    describe "数学の演算" do
      it "1と2の和が3になる" do
        json_string = "{\"type\":\"+\",\"left\":1,\"right\":2}"
        expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(3)
      end

      it "1と2の差が-1になる" do
        json_string = "{\"type\":\"-\",\"left\":1,\"right\":2}"
        expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(-1)
      end

      it "2と3の積が6になる" do
        json_string = "{\"type\":\"*\",\"left\":2,\"right\":3}"
        expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(6)
      end

      it "6と3の商が2になる" do
        json_string = "{\"type\":\"/\",\"left\":6,\"right\":3}"
        expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(2)
      end
    end

    describe "比較演算" do
      describe "小なり" do
        it "1<2がtrue" do
          json_string = "{\"type\":\"<\",\"left\":1,\"right\":2}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(true)
        end

        it "2<1がfalse" do
          json_string = "{\"type\":\"<\",\"left\":2,\"right\":1}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(false)
        end
      end

      describe "大なり" do
        it "2>1がtrue" do
          json_string = "{\"type\":\">\",\"left\":2,\"right\":1}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(true)
        end

        it "1>2がfalse" do
          json_string = "{\"type\":\">\",\"left\":1,\"right\":2}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(false)
        end
      end

      describe "小なりイコール" do
        it "1<=2がtrue" do
          json_string = "{\"type\":\"<=\",\"left\":1,\"right\":2}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(true)
        end

        it "2<=1がfalse" do
          json_string = "{\"type\":\"<=\",\"left\":2,\"right\":1}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(false)
        end

        it "2<=2がtrue" do
          json_string = "{\"type\":\"<=\",\"left\":2,\"right\":2}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(true)
        end
      end

      describe "大なりイコール" do
        it "2>=1がtrue" do
          json_string = "{\"type\":\">=\",\"left\":2,\"right\":1}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(true)
        end

        it "1>=2がfalse" do
          json_string = "{\"type\":\">=\",\"left\":1,\"right\":2}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(false)
        end

        it "2>=2がtrue" do
          json_string = "{\"type\":\">=\",\"left\":2,\"right\":2}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(true)
        end
      end

      describe "イコール" do
        it "2==2がtrue" do
          json_string = "{\"type\":\"==\",\"left\":2,\"right\":2}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(true)
        end

        it "2==1がfalse" do
          json_string = "{\"type\":\"==\",\"left\":2,\"right\":1}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(false)
        end
      end

      describe "ノットイコール" do
        it "2!=1がtrue" do
          json_string = "{\"type\":\"!=\",\"left\":2,\"right\":1}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(true)
        end

        it "2!=2がfalse" do
          json_string = "{\"type\":\"!=\",\"left\":2,\"right\":2}"
          expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(false)
        end
      end
    end

    describe "連接" do
      it "もっとも右の式の評価結果が全体の評価結果になる" do
        json_string = "{\"type\":\"seq\",\"expressions\":[1,2,3]}"
        expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(3)
      end
    end

    describe "if" do
      it "条件がtrueならthen節が評価される" do
        json_string = "{\"type\":\"if\",\"condition\":{\"type\":\"==\",\"left\":2,\"right\":2},\"then\":1,\"else\":2}"
        expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(1)
      end

      it "条件がfalseならelse節が評価される" do
        json_string = "{\"type\":\"if\",\"condition\":{\"type\":\"!=\",\"left\":2,\"right\":2},\"then\":1,\"else\":2}"
        expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(2)
      end

      it "条件がfalseでかつelse_clauseがない場合はnilが返る" do
        json_string = "{\"type\":\"if\",\"condition\":{\"type\":\"!=\",\"left\":2,\"right\":2},\"then\":1}"
        expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(nil)
      end
    end

    describe "配列" do
      it "配列の要素をインデックスで参照できる" do
        json_string = "{\"type\":\"index\",\"array\":[1,2,3],\"index\":1}"
        expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(2)
      end
    end
  end
end
