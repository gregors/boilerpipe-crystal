require "../spec_helper"

module Boilerpipe::Filters
  describe BoilerplateBlockFilter do
    describe "#process" do
      context "with INSTANCE_KEEP_TITLE" do
          it "keeps the text block for :TITLE labels" do
          text_block1 = Boilerpipe::Document::TextBlock.new("one").tap { |t| t.add_label(:TITLE) }
          text_block2 = Boilerpipe::Document::TextBlock.new("two")
          text_block3 = Boilerpipe::Document::TextBlock.new("three")
          text_blocks = [text_block1, text_block2, text_block3]

          doc = Boilerpipe::Document::TextDocument.new("", text_blocks)

          doc.text_blocks.size.should eq 3
          filter = BoilerplateBlockFilter::INSTANCE_KEEP_TITLE
          filter.process(doc)
          doc.text_blocks.size.should eq 1
        end
      end

      context "with no label to keep" do
        it "removes the text block" do
          text_block1 = Boilerpipe::Document::TextBlock.new("one")
          text_block2 = Boilerpipe::Document::TextBlock.new("two")
          text_block3 = Boilerpipe::Document::TextBlock.new("three")
          text_blocks = [text_block1, text_block2, text_block3]

          doc = Boilerpipe::Document::TextDocument.new("", text_blocks)

          doc.text_blocks.size.should eq 3
          filter = BoilerplateBlockFilter::INSTANCE_KEEP_TITLE
          filter.process(doc)
          doc.text_blocks.size.should eq 0
        end
      end
    end
  end
end
