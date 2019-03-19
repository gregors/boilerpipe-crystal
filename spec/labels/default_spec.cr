require "../spec_helper"

module Boilerpipe::Labels
  describe Default do
    it "has markup prefix" do
      Boilerpipe::Labels::Default::MARKUP_PREFIX.should eq '<'
    end
  end
end
