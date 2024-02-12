RSpec.describe MinisRb::MEvaluators do
    describe '数学の演算' do
        it '1と2の和が3になる' do
            expr = MinisRb::MASTBuilders.add(
                MinisRb::MASTBuilders.int(1),
                MinisRb::MASTBuilders.int(2)
            )
            expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(3)
        end

        it '1と2の差が-1になる' do
            expr = MinisRb::MASTBuilders.sub(
                MinisRb::MASTBuilders.int(1),
                MinisRb::MASTBuilders.int(2)
            )
            expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(-1)
        end

        it '2と3の積が6になる' do
            expr = MinisRb::MASTBuilders.mul(
                MinisRb::MASTBuilders.int(2),
                MinisRb::MASTBuilders.int(3)
            )
            expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(6)
        end

        it '6と3の商が2になる' do
            expr = MinisRb::MASTBuilders.div(
                MinisRb::MASTBuilders.int(6),
                MinisRb::MASTBuilders.int(3)
            )
            expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(2)
        end
    end

    describe '比較演算' do
        describe '小なり' do
            it '1<2がtrue' do
                expr = MinisRb::MASTBuilders.lt(
                    MinisRb::MASTBuilders.int(1),
                    MinisRb::MASTBuilders.int(2)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
            end

            it '2<1がfalse' do
                expr = MinisRb::MASTBuilders.lt(
                    MinisRb::MASTBuilders.int(2),
                    MinisRb::MASTBuilders.int(1)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(false)
            end
        end

        describe '大なり' do
            it '2>1がtrue' do
                expr = MinisRb::MASTBuilders.gt(
                    MinisRb::MASTBuilders.int(2),
                    MinisRb::MASTBuilders.int(1)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
            end

            it '1>2がfalse' do
                expr = MinisRb::MASTBuilders.gt(
                    MinisRb::MASTBuilders.int(1),
                    MinisRb::MASTBuilders.int(2)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(false)
            end
        end

        describe '小なりイコール' do
            it '1<=2がtrue' do
                expr = MinisRb::MASTBuilders.lte(
                    MinisRb::MASTBuilders.int(1),
                    MinisRb::MASTBuilders.int(2)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
            end

            it '2<=1がfalse' do
                expr = MinisRb::MASTBuilders.lte(
                    MinisRb::MASTBuilders.int(2),
                    MinisRb::MASTBuilders.int(1)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(false)
            end

            it '2<=2がtrue' do
                expr = MinisRb::MASTBuilders.lte(
                    MinisRb::MASTBuilders.int(2),
                    MinisRb::MASTBuilders.int(2)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
            end
        end

        describe '大なりイコール' do
            it '2>=1がtrue' do
                expr = MinisRb::MASTBuilders.gte(
                    MinisRb::MASTBuilders.int(2),
                    MinisRb::MASTBuilders.int(1)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
            end

            it '1>=2がfalse' do
                expr = MinisRb::MASTBuilders.gte(
                    MinisRb::MASTBuilders.int(1),
                    MinisRb::MASTBuilders.int(2)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(false)
            end

            it '2>=2がtrue' do
                expr = MinisRb::MASTBuilders.gte(
                    MinisRb::MASTBuilders.int(2),
                    MinisRb::MASTBuilders.int(2)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
            end
        end

        describe 'イコール' do
            it '1==1がtrue' do
                expr = MinisRb::MASTBuilders.eq(
                    MinisRb::MASTBuilders.int(1),
                    MinisRb::MASTBuilders.int(1)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
            end

            it '1==2がfalse' do
                expr = MinisRb::MASTBuilders.eq(
                    MinisRb::MASTBuilders.int(1),
                    MinisRb::MASTBuilders.int(2)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(false)
            end
        end

        describe 'ノットイコール' do
            it '1!=2がtrue' do
                expr = MinisRb::MASTBuilders.neq(
                    MinisRb::MASTBuilders.int(1),
                    MinisRb::MASTBuilders.int(2)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(true)
            end

            it '1!=1がfalse' do
                expr = MinisRb::MASTBuilders.neq(
                    MinisRb::MASTBuilders.int(1),
                    MinisRb::MASTBuilders.int(1)
                )
                expect(MinisRb::MEvaluators.evaluate(expr, {})).to eq(false)
            end
        end
    end
end
