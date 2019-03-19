require "../spec_helper"

module Boilerpipe::Filters
  describe BlockProximityFusion do


    describe "#process" do
      context "where blocks exceed distance" do
        it "doesnt change blocks" do
          text_block1 = Boilerpipe::Document::TextBlock.new("one",   0, 0, 0, 0, 0)
          text_block2 = Boilerpipe::Document::TextBlock.new("two",   0, 0, 0, 0, 1)
          text_block3 = Boilerpipe::Document::TextBlock.new("three", 0, 0, 0, 0, 2)
          text_block4 = Boilerpipe::Document::TextBlock.new("four",  0, 0, 0, 0, 3)

          text_block1.content = true
          text_block2.content = false
          text_block3.content = false
          text_block4.content = true

          text_blocks = [text_block1, text_block2, text_block3, text_block4]
          doc =  Boilerpipe::Document::TextDocument.new("", text_blocks)

          doc.text_blocks.size.should eq 4
          filter = BlockProximityFusion.new(1, true, false)
          filter.process(doc)
          doc.text_blocks.size.should eq 4
        end
      end

      context "where blocks do not exceed distance" do
        it "Fuses adjacent blocks" do
          text_block1 = Boilerpipe::Document::TextBlock.new("one",   0, 0, 0, 0, 0)
          text_block2 = Boilerpipe::Document::TextBlock.new("two",   0, 0, 0, 0, 1)
          text_block3 = Boilerpipe::Document::TextBlock.new("three", 0, 0, 0, 0, 2)
          text_block4 = Boilerpipe::Document::TextBlock.new("four",  0, 0, 0, 0, 3)

          text_block1.content = true
          text_block2.content = false
          text_block3.content = false
          text_block4.content = true

          text_blocks = [text_block1, text_block2, text_block3, text_block4]
          doc =  Boilerpipe::Document::TextDocument.new("", text_blocks)

          doc.text_blocks.last.text.size.should eq 4
          filter = BlockProximityFusion.new(1, false, false)
          filter.process(doc)
          doc.text_blocks.last.text.should eq "three\nfour"
        end

        it "Removes one of the blocks from the Text Document" do
          text_block1 = Boilerpipe::Document::TextBlock.new("one",   0, 0, 0, 0, 0)
          text_block2 = Boilerpipe::Document::TextBlock.new("two",   0, 0, 0, 0, 1)
          text_block3 = Boilerpipe::Document::TextBlock.new("three", 0, 0, 0, 0, 2)
          text_block4 = Boilerpipe::Document::TextBlock.new("four",  0, 0, 0, 0, 3)

          text_block1.content = true
          text_block2.content = false
          text_block3.content = false
          text_block4.content = true

          text_blocks = [text_block1, text_block2, text_block3, text_block4]
          doc =  Boilerpipe::Document::TextDocument.new("", text_blocks)

          doc.text_blocks.size.should eq 4
          filter = BlockProximityFusion.new(1, false, false)
          filter.process(doc)
          doc.text_blocks.size.should eq 3
        end
      end

      context "when the Text Document only has one text block" do
        it "doesnt change blocks" do
          text_block1 = Boilerpipe::Document::TextBlock.new("one",   0, 0, 0, 0, 0)
          text_block1.content = true

          doc = Boilerpipe::Document::TextDocument.new("", [text_block1])

          filter = BlockProximityFusion.new(1, false, false)
          filter.process(doc).should eq false
        end
      end

      context "When content_only is specified but no content exists" do
        it "doesnt change blocks" do
          text_block1 = Boilerpipe::Document::TextBlock.new("one",   0, 0, 0, 0, 0)
          text_block2 = Boilerpipe::Document::TextBlock.new("two",   0, 0, 0, 0, 1)
          text_block3 = Boilerpipe::Document::TextBlock.new("three", 0, 0, 0, 0, 2)
          text_block4 = Boilerpipe::Document::TextBlock.new("four",  0, 0, 0, 0, 3)

          text_block1.content = false
          text_block2.content = false
          text_block3.content = false
          text_block4.content = false

          text_blocks = [text_block1, text_block2, text_block3, text_block4]
          doc = Boilerpipe::Document::TextDocument.new("", text_blocks)

          doc.text_blocks.size.should eq 4
          filter = BlockProximityFusion.new(1, true, false)
          filter.process(doc)
          doc.text_blocks.size.should eq 4
        end
      end

      context "when same tag level is specified but tag levels arent the same" do
        it "doesnt change blocks" do
          text_block1 = Boilerpipe::Document::TextBlock.new("one",   0, 0, 0, 0, 0)
          text_block2 = Boilerpipe::Document::TextBlock.new("two",   0, 0, 0, 0, 1)
          text_block3 = Boilerpipe::Document::TextBlock.new("three", 0, 0, 0, 0, 2)
          text_block4 = Boilerpipe::Document::TextBlock.new("four",  0, 0, 0, 0, 3)

          text_block1.set_tag_level 1
          text_block2.set_tag_level 2
          text_block3.set_tag_level 3
          text_block3.set_tag_level 4

          text_blocks = [text_block1, text_block2, text_block3, text_block4]
          doc = Boilerpipe::Document::TextDocument.new("", text_blocks)

          doc.text_blocks.size.should eq 4
          filter = BlockProximityFusion.new(1, false, true)
          filter.process(doc)
          doc.text_blocks.size.should eq 4
        end
      end
    end
  end
end
