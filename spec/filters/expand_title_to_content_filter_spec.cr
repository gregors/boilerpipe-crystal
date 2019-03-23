require "../spec_helper"

module Boilerpipe::Filters
  describe ExpandTitleToContentFilter do
    describe "#process" do

      context "if a Title textblock has a subsequent Content textblock" do
        it "marks all textblocks in between title and know content as content if they might be content" do
          text_block = Boilerpipe::Document::TextBlock
          text_block1 = text_block.new("one", 3, 0, 0, 0, 0)
          text_block2 = text_block.new("two", 3, 1, 1, 0, 1)
          text_block3 = text_block.new("three", 5, 2, 1, 0, 2)
          text_blocks = [text_block1, text_block2, text_block3]

          text_block1.add_label(:TITLE)
          text_block1.content = false

          text_block2.add_label(:MIGHT_BE_CONTENT)
          text_block2.content = false

          text_block3.content = true

          doc = Boilerpipe::Document::TextDocument.new("", text_blocks)
          text_block1.content.should eq false
          text_block2.content.should eq false
          text_block3.content.should eq true

          ExpandTitleToContentFilter.process(doc)
          text_block1.content.should eq false
          text_block2.content.should eq true
          text_block3.content.should eq true
        end
      end

      context "if a Title textblock doesnt have a subsequent Content textblock" do

        it "doesnt mark textblocks as content" do
          text_block = Boilerpipe::Document::TextBlock
          text_block1 = text_block.new("one", 3, 0, 0, 0, 0)
          text_block2 = text_block.new("two", 3, 1, 1, 0, 1)

          text_block1.add_label(:TITLE)
          text_block1.content = false
          text_block2.add_label(:MIGHT_BE_CONTENT)
          text_block2.content = false

          doc = Boilerpipe::Document::TextDocument.new("", [text_block1])
          text_block1.content.should eq false
          text_block2.content.should eq false
          ExpandTitleToContentFilter.process(doc)
          text_block1.content.should eq false
          text_block2.content.should eq false
        end
      end
    end
  end
end
