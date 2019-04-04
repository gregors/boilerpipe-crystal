require "../spec_helper"

module Boilerpipe::Filters
  describe KeepLargestBlockFilter do
    describe ".INSTANCE_EXPAND_TO_SAME_TAGLEVEL_MIN_WORDS" do
      describe "#process" do
        context "with a non-content block more than 150 chars" do

          it "expands same tag level with text more than 150" do
            text_block = Boilerpipe::Document::TextBlock
            text_block1 = text_block.new("one", 3, 0, 0, 1, 0)
            text_block2 = text_block.new("largest", 7, 0, 0, 1, 0).tap { |t| t.content = true }
            text_block3 = text_block.new("3" * 150, 150, 0, 0, 1, 0)
            text_blocks = [text_block1, text_block2, text_block3]
            doc = Boilerpipe::Document::TextDocument.new("", text_blocks)

            text_block3.is_content?.should eq false
            KeepLargestBlockFilter::INSTANCE_EXPAND_TO_SAME_TAGLEVEL_MIN_WORDS.process(doc)
            text_block3.is_content?.should eq true
          end
        end

        context "with a non-content block less than 150 chars" do

          it "expands same tag level with text more than 150" do
            text_block = Boilerpipe::Document::TextBlock
            text_block1 = text_block.new("one", 3, 0, 0, 1, 0)
            text_block2 = text_block.new("largest", 7, 0, 0, 1, 0).tap { |t| t.content = true }
            text_block3 = text_block.new("3", 3, 0, 0, 1, 0)
            text_blocks = [text_block1, text_block2, text_block3]
            doc = Boilerpipe::Document::TextDocument.new("", text_blocks)

            text_block3.is_content?.should eq false
            KeepLargestBlockFilter::INSTANCE_EXPAND_TO_SAME_TAGLEVEL_MIN_WORDS.process(doc)
            text_block3.is_content?.should eq false
          end
        end
      end
    end
  end
end
