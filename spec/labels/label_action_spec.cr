require "../spec_helper"

module Boilerpipe::Labels
  describe LabelAction do
    describe ".new" do
      it "accepts labels" do
        la = LabelAction.new(["one", "two"])
        la.should_not be nil
      end

      it "defaults empty labels" do
        la = LabelAction.new
        la.should_not be nil
        la.labels.should eq [] of String
      end
    end

    describe "#labels" do
      it "returns labels" do
        la = LabelAction.new(["one", "two"])
        la.labels.should eq ["one", "two"]
      end
    end

    describe "#add_to" do
      # it "adds labels to textblock"
    end

    describe "#to_s" do
      it "returns debug string" do
        la = LabelAction.new(["one", "two"])
        la.to_s.should eq "one,two"
      end
    end
  end
end
