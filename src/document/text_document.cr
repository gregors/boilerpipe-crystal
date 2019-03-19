module Boilerpipe
  module Document
    class TextDocument
      getter text_blocks : Array(TextBlock)
      property title : String

      def initialize(@title, @text_blocks : Array(TextBlock))
      end

      def content
        text(true, false)
      end

      def text(include_content : Bool, include_noncontent : Bool)
        s = "" 
        @text_blocks.each do |text_block|
          case text_block.is_content?
          when true
            next unless include_content

            s += text_block.text
            s += "\n"
          when false
            next unless include_noncontent

            s += text_block.text
            s += "\n"
          end
        end
        s
      end

      def replace_text_blocks!(new_blocks)
        @text_blocks = new_blocks
      end

      def debug_s
        @text_blocks.map{|tb| tb.to_s}.join("\n")
      end
    end
  end
end
