require "../spec_helper"

module Boilerpipe::Filters
  describe IgnoreBlocksAfterContentFilter do
    describe "#process" do
      context "with more than 60 words" do
        it "marks text blocks after end of text labels as non-content" do
          text = "What a great day! This is great! Yes! Ha ha"
          text_blocks = [
              content_text_block(text),
              content_text_block(text),
              content_text_block(text),
              content_text_block(text),
              content_text_block(text),
              content_text_block(text).tap { |t| t.labels << :INDICATES_END_OF_TEXT },
              content_text_block(text)
            ]

          tb = Boilerpipe::Document::TextBlock
          doc = Boilerpipe::Document::TextDocument.new "", text_blocks
          IgnoreBlocksAfterContentFilter.process(doc)
          doc.text_blocks.last.content.should eq false
        end
      end

      context "with less than 60 words" do
        it "does not mark text blocks after end of text" do
          text = "What a great day! This is great! Yes! Ha ha"
          text_blocks = [
              content_text_block(text),
              content_text_block(text).tap { |t| t.labels << :INDICATES_END_OF_TEXT },
              content_text_block(text)
            ]

          tb = Boilerpipe::Document::TextBlock
          doc = Boilerpipe::Document::TextDocument.new "", text_blocks
          IgnoreBlocksAfterContentFilter.process(doc)
          doc.text_blocks.last.content.should eq true
        end
      end
    end
  end
end
