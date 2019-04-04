require "../spec_helper"

module Boilerpipe::Filters
  describe MinWordsFilter do
    describe "#process" do
      it "keeps blocks with at least k words" do
        text_block = Boilerpipe::Document::TextBlock
        text_block1 = text_block.new("one two three", 3)
        text_block2 = text_block.new("one two", 2)
        text_block1.content = true
        text_block2.content = true
        text_blocks = [text_block1, text_block2]

        doc = Boilerpipe::Document::TextDocument.new("", text_blocks)

        text_block1.content.should eq true
        text_block2.content.should eq true
        MinWordsFilter.process 3, doc
        text_block1.content.should eq true
        text_block2.content.should eq false
      end
    end
  end
end
