require "../spec_helper"

module Boilerpipe
  describe Document::TextBlock do
    describe ".new" do
      context "with text input" do
        it "sets text" do
          subject = Document::TextBlock.new "hello"
          subject.text.should eq "hello"
        end

        # used in image extraction / highligher
        # not yet implemented
        # it "bit set of containedTextElements"

        it "sets number of words" do
          subject = Document::TextBlock.new "hello"
          subject.num_words.should eq 0
        end

        it "number of words in anchor text" do
          subject = Document::TextBlock.new "hello"
          subject.num_words_in_anchor_text.should eq 0
        end

        it "number of words in wrapped lines" do
          subject = Document::TextBlock.new "hello"
          subject.num_words_in_wrapped_lines.should eq 0
        end

        it "number of wrapped lines" do
          subject = Document::TextBlock.new "hello"
          subject.num_wrapped_lines.should eq 1
        end

        it "offset blocks" do
          subject = Document::TextBlock.new "hello"
          subject.offset_blocks_start.should eq 0
          subject.offset_blocks_end.should eq 0
        end

        it "link_density" do
          subject = Document::TextBlock.new "hello"
          subject.link_density.should eq 0
        end

        it "text_density" do
          subject = Document::TextBlock.new "hello"
          subject.text_density.should eq 0
        end
      end
    end

    describe "#merge_next" do
      it "merges another TextBlock" do
        subject = Document::TextBlock.new "hello"
        another_block = Document::TextBlock.new "good-bye"
        subject.merge_next(another_block)
        subject.text.should eq "hello\ngood-bye"
      end
    end

    describe "#add_label" do
      it "adds a label" do
        subject = Document::TextBlock.new "hello"
        subject.labels.size.should eq 1
        subject.add_label(:another_label)
        subject.labels.size.should eq 2
      end
    end

    describe "#add_labels" do
      it "adds a set of labels" do
        subject = Document::TextBlock.new "hello"
        subject.labels.size.should eq 1

        labels = Set{:one, :two, :three}
        subject.add_labels(labels)

        subject.labels.size.should eq 4
      end
    end

    describe "#has_label" do
      it "returns true if it exists" do
        subject = Document::TextBlock.new "hello"
        subject.add_label(:label_1)
        subject.has_label?(:label_1).should_not be_nil
      end

      it "returns false if it does not exist" do
        subject = Document::TextBlock.new "hello"
        subject.has_label?(:label_1).should_not be_nil
      end
    end

    describe "#remove_label" do
      it "removes the label" do
        subject = Document::TextBlock.new "hello"
        subject.add_label(:label_1)
        subject.labels.size.should eq 1
        subject.remove_label(:label_1)
        subject.labels.size.should eq 0
      end
    end

    describe "#is_content?" do
      # it "returns true if content"
      # it "returns false if not content"
    end

    describe "#is_content = " do
      # it "sets the content flag"
    end

    describe "#clone" do
      # it "clones the TextBlock"
    end

    describe "#is_content?" do
    end
  end
end
