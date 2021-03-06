require "../spec_helper"

module Boilerpipe::Filters
  describe NumWordsRulesClassifier do

    describe "#process" do
      describe "with a content text block" do

        it "labels the text block as content" do
          tb = Boilerpipe::Document::TextBlock
          text_blocks = [ tb.new("What a great day!"), tb.new("What a terrible day! oh no no no no no no no no no no no no no", 16)]
          doc = Boilerpipe::Document::TextDocument.new "", text_blocks

          NumWordsRulesClassifier.process(doc)
          doc.text_blocks.first.is_content?.should eq true
        end
      end

      describe "with a non-content text block" do
        it "labels the text block as non-content" do
          tb = Boilerpipe::Document::TextBlock
          text_blocks = [ tb.new("What a great day!"), tb.new("What a great day!", 4) ]
          doc = Boilerpipe::Document::TextDocument.new "", text_blocks

          NumWordsRulesClassifier.process(doc)
          doc.text_blocks.first.is_content?.should eq false
        end
      end
    end
  end
end
