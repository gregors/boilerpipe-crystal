require "../spec_helper"

module Boilerpipe::Filters
  describe MinClauseWordsFilter do
    describe "#process" do
      it "keeps blocks with one clause of at least 5 words" do
        text_block = Boilerpipe::Document::TextBlock
        text_block1 = text_block.new("one two three four five, one two", 7)
        text_block1.content = true
        text_block2 = text_block.new("one two", 2)
        text_block2.content = true
        text_blocks = [text_block1, text_block2]

        doc = Boilerpipe::Document::TextDocument.new("", text_blocks)

        text_block1.content.should eq true
        text_block2.content.should eq true
        MinClauseWordsFilter.process doc
        text_block1.content.should eq true
        text_block2.content.should eq false
      end
    end
  end
end
