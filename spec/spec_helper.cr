require "spec"
require "../src/boilerpipe-crystal"

def content_text_block(s)
  ::Boilerpipe::Document::TextBlock.new(s, 10, 0, 10, 1, 0)
    .tap { |t| t.content = true }
end
