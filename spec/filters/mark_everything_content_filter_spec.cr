require "../spec_helper"

module Boilerpipe::Filters
  describe MarkEverythingContentFilter do
    describe "#process" do
      it "marks everything as content" do
        text_block1 = Boilerpipe::Document::TextBlock.new("one",   0, 0, 0, 0, 0)
        text_block2 = Boilerpipe::Document::TextBlock.new("two",   0, 0, 0, 0, 1)
        text_block3 = Boilerpipe::Document::TextBlock.new("three", 0, 0, 0, 0, 2)
        text_block4 = Boilerpipe::Document::TextBlock.new("four",  0, 0, 0, 0, 3)

        text_block1.content = true
        text_block2.content = false
        text_block3.content = false
        text_block4.content = true

        text_blocks = [text_block1, text_block2, text_block3, text_block4]

        doc = Boilerpipe::Document::TextDocument.new("", text_blocks)

        doc.text_blocks.select{ |x| x.is_content? }.size.should eq 2
        MarkEverythingContentFilter.process(doc)
        doc.text_blocks.select{ |x| x.is_content? }.size.should eq 4
      end
    end
  end
end
