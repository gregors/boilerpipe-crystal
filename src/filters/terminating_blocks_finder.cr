# Finds blocks which are potentially indicating the end of an article
# text and marks them with INDICATES_END_OF_TEXT. This can be used
# in conjunction with a downstream IgnoreBlocksAfterContentFilter.

module Boilerpipe::Filters
  class TerminatingBlocksFinder
    def self.process(doc)
      doc.text_blocks.each do |tb|
        next unless tb.num_words < 15

        if tb.text.size >= 8 && finds_match?(tb.text.downcase)
          tb.labels << :INDICATES_END_OF_TEXT
        elsif tb.link_density == 1.0 && tb.text == "comment"
          tb.labels << :INDICATES_END_OF_TEXT
        end
      end
       
      doc
    end

    def self.finds_match?(text)
      text.starts_with?("comments") ||
        text =~ /^\d+ (comments|users responded in)/ || # starts with number
        text.starts_with?("© reuters") ||
        text.starts_with?("please rate this") ||
        text.starts_with?("post a comment") ||
        text.includes?("what you think...") ||
        text.includes?("add your comment") ||
        text.includes?("add comment") ||
        # TODO add this and test
        # text.includes?("leave a reply") ||
        # text.includes?("leave a comment") ||
        # text.includes?("show comments") ||
        # text.includes?("Share this:") ||
        text.includes?("reader views") ||
        text.includes?("have your say") ||
        text.includes?("reader comments") ||
        text.includes?("rätta artikeln") ||
        text == "thanks for your comments - this feedback is now closed"
    end
  end
end
