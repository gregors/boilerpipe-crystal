require "../spec_helper"

module Boilerpipe::Filters
  describe TerminatingBlocksFinder do
    describe "#process" do
      context "the text is ending text" do
        it "adds the ending text label to the text block" do
          text = "add comment"
          text_blocks = [ ::Boilerpipe::Document::TextBlock.new(text, 2) ]
          doc = Boilerpipe::Document::TextDocument.new "", text_blocks
          TerminatingBlocksFinder.process(doc)
          doc.text_blocks.last.labels.first.should eq :INDICATES_END_OF_TEXT
        end
      end

      context "the text is not ending text" do
        it "doesnt add ending text label" do
          text  = "This is not ending text"
          text_blocks = [ ::Boilerpipe::Document::TextBlock.new(text, 2) ]
          doc = Boilerpipe::Document::TextDocument.new "", text_blocks

          TerminatingBlocksFinder.process(doc)
          doc.text_blocks.last.labels.size.should eq 0
        end
      end
    end
  end
end
