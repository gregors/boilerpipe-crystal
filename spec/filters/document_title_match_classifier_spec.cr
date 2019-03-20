require "../spec_helper"

module Boilerpipe::Filters
  describe DocumentTitleMatchClassifier do

    describe ".new" do
      context "takes a string with a title" do
        it "makes potential titles" do
          input = "Extracting Text For Fun And Profit - Greg"
          subject =  DocumentTitleMatchClassifier.new input
          expected = [
            "extracting text for fun and profit - greg",
            "extracting text for fun and profit",
            "greg"
          ]
          subject.potential_titles.to_a.should eq expected
        end
      end
    end

    describe "#process" do
    context "has a text document with a title" do
        it "marks a text block as :TITLE" do
          input = "Extracting Text For Fun And Profit - Greg"
          subject =  DocumentTitleMatchClassifier.new input
          text_blocks = [
                  Boilerpipe::Document::TextBlock.new("What a great day!"),
                  Boilerpipe::Document::TextBlock.new("What a terrible day!"),
                  Boilerpipe::Document::TextBlock.new(input)
                ]
          doc = Boilerpipe::Document::TextDocument.new(input, text_blocks)
          subject.process(doc)
          text_blocks.last.labels.first.should eq :TITLE
        end
      end
    end

    # describe "#potential_titles"

    # these are private but let"s start with testing to get parity
    # describe "#longest_part"
  end
end
