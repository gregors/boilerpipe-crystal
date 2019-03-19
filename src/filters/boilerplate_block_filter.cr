# Removes TextBlocks which have explicitly been marked as "not content".

module Boilerpipe::Filters
  class BoilerplateBlockFilter
    def initialize(@label_to_keep : Symbol)
    end

    INSTANCE_KEEP_TITLE = BoilerplateBlockFilter.new(:TITLE)

    def process(doc)
      deletes = Array(Document::TextBlock).new

      doc.text_blocks.each do |tb|
        if tb.is_not_content? && (@label_to_keep.nil? || !tb.has_label?(:TITLE))
          deletes << tb 
        end
      end

      deletes.each do |tb|
        doc.text_blocks.delete(tb)
      end

      doc
    end
  end
end
