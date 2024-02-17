# frozen_string_literal: true

RSpec.describe MinisRb::MJsonEvaluator do
  describe "数学の演算" do
    it "1と2の和が3になる" do
      json_string = "{\"type\":\"+\",\"left\":1,\"right\":2}"
      expect(MinisRb::MJsonEvaluator.evaluate_json(json_string)).to eq(3)
    end
  end
end
