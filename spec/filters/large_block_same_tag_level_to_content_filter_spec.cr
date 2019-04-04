require "../spec_helper"

module Boilerpipe::Filters
  describe LargeBlockSameTagLevelToContentFilter do

    describe "with large text blocks at the same level" do
      it "marks as content" do
        text_block = Boilerpipe::Document::TextBlock
        text_block1 = text_block.new("one", 3, 0, 0, 1, 0)

        main_content = text_block.new("1" * 200, 200, 0, 0, 1, 0)
          .tap { |t| t.content = true }
          .tap { |t| t.add_label(:VERY_LIKELY_CONTENT) }

        text_block3 = text_block.new("3" * 150, 150, 0, 0, 1, 0)
        text_blocks = [text_block1, main_content, text_block3]

        doc = Boilerpipe::Document::TextDocument.new("", text_blocks)

        text_block1.is_content?.should eq false
        main_content.is_content?.should eq true
        text_block3.is_content?.should eq false

        LargeBlockSameTagLevelToContentFilter.process(doc)

        text_block1.is_content?.should eq false
        main_content.is_content?.should eq true
        text_block3.is_content?.should eq true
      end
    end
  end
end
