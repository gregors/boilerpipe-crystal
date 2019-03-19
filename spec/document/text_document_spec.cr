require "../spec_helper"

module Boilerpipe
  describe Document::TextDocument do

    it "Creates a new Text document with given TextBlocks and given title" do
      text_blocks = [Document::TextBlock.new("one"), Document::TextBlock.new("two")]
      doc = Document::TextDocument.new("my title", text_blocks)
      doc.should_not be_nil
    end

    it "Returns the TextBlocks of this document" do
      text_blocks = [Document::TextBlock.new("one"), Document::TextBlock.new("two")]
      doc = Document::TextDocument.new("my title", text_blocks)
      doc.text_blocks.should eq text_blocks
    end

    it "Returns the main title for this document, or null if no such title has been set" do
      text_blocks = [Document::TextBlock.new("one"), Document::TextBlock.new("two")]
      doc = Document::TextDocument.new("my title", text_blocks)
      doc.title.should eq "my title"
    end

    it "Updates the main title for this document" do
      text_blocks = [Document::TextBlock.new("one"), Document::TextBlock.new("two")]
      doc = Document::TextDocument.new("my title", text_blocks)
      doc.title = "new title"
      doc.title.should eq "new title"
    end

    it "Returns the content" do
      text_blocks = [Document::TextBlock.new("one"), Document::TextBlock.new("two")]
      text_blocks.each { |tb| tb.content = true }

      doc = Document::TextDocument.new("my title", text_blocks)
      content = doc.content()
      content.should eq "one\ntwo\n"
    end

    it "Returns the content, non-content or both" do
      text_blocks = [Document::TextBlock.new("one"), Document::TextBlock.new("two")]
      text_blocks.first.content = true
      doc = Document::TextDocument.new("my title", text_blocks)
      content = doc.text(true, true)
      content.should eq "one\ntwo\n"
    end

    it "Returns detailed debugging information about the contained TextBlocks" do
      text_blocks = [Document::TextBlock.new("one"), Document::TextBlock.new("two")]
      doc = Document::TextDocument.new("my title", text_blocks)
      doc.debug_s.should eq "[0-0;tl=0; nw=0;nwl=1;ld=0.0]\tBOILERPLATE,null\none\n[0-0;tl=0; nw=0;nwl=1;ld=0.0]\tBOILERPLATE,null\ntwo"
    end
  end
end
