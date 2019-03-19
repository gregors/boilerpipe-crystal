require "../spec_helper"

module Boilerpipe
  describe UnicodeTokenizer do
    it "tokenizes words" do
      input = "How are you?"
      output = UnicodeTokenizer.tokenize(input)
      output.should eq(["How", "are", "you?"])
    end

    it "splits on the unicode hidden separator" do
      input = "How\u2063are\u2063you?"
      output = UnicodeTokenizer.tokenize(input)
      output.should eq(["How", "are", "you?"])
    end

    it "leaves symbols" do
      input = "How @@re 'y()u?'"
      output = UnicodeTokenizer.tokenize(input)
      output.should eq(["How", "@@re", "'y()u?'"])
    end
  end
end
