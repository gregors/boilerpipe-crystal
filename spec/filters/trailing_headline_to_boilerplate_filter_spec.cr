require "../spec_helper"

module Boilerpipe::Filters
  describe TrailingHeadlineToBoilerplateFilter do

    describe "#process" do
      describe "when a text block is content" do
        describe "and has a HEADING label" do
          it "sets the text block content to false" do
            text = "What a great day! This is great! Yes! Ha ha"
            tb = Boilerpipe::Document::TextBlock.new text
            tb.content = true
            tb.add_label(:HEADING)
            doc = Boilerpipe::Document::TextDocument.new "", [tb]
            TrailingHeadlineToBoilerplateFilter.process(doc)
            doc.text_blocks.first.content.should eq false
          end
        end

        describe "and does not have a HEADING label" do
          it "does not change the content to false" do
            text = "What a great day! This is great! Yes! Ha ha"
            tb = Boilerpipe::Document::TextBlock.new text
            tb.content = true
            doc = Boilerpipe::Document::TextDocument.new "", [tb]
            TrailingHeadlineToBoilerplateFilter.process(doc)
            doc.text_blocks.first.content.should eq true
          end
        end
      end
    end
  end
end
