require "../spec_helper"

module Boilerpipe::Filters
  describe SimpleBlockFusionProcessor do

    context "where blocks have same text density" do

      it "the blocks are merged" do
        text_block1 = Boilerpipe::Document::TextBlock.new("one",   0, 0, 0, 0, 0)
        text_block2 = Boilerpipe::Document::TextBlock.new("two",   0, 0, 0, 0, 1)
        text_block3 = Boilerpipe::Document::TextBlock.new("three", 0, 0, 0, 0, 2)
        text_block4 = Boilerpipe::Document::TextBlock.new("four",  0, 0, 0, 0, 3)
        text_blocks  = [text_block1, text_block2, text_block3, text_block4]
        doc = Boilerpipe::Document::TextDocument.new("", text_blocks)

        doc.text_blocks.size.should eq 4
        SimpleBlockFusionProcessor.process(doc)
        doc.text_blocks.size.should eq 1
      end
    end

    context "where blocks have different text density" do

      it "the blocks are not merged" do
        text_block1 = Boilerpipe::Document::TextBlock.new("one",   0, 0, 1, 1, 0)
        text_block2 = Boilerpipe::Document::TextBlock.new("two",   0, 0, 1, 2, 1)
        text_block3 = Boilerpipe::Document::TextBlock.new("three", 0, 0, 1, 3, 2)
        text_block4 = Boilerpipe::Document::TextBlock.new("four",  0, 0, 1, 4, 3)
        text_blocks  = [text_block1, text_block2, text_block3, text_block4]
        doc = Boilerpipe::Document::TextDocument.new("", text_blocks)

        doc.text_blocks.size.should eq 4
        SimpleBlockFusionProcessor.process(doc)
        doc.text_blocks.size.should eq 4
      end
    end
  end
end
