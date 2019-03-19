module Boilerpipe
  class UnicodeTokenizer
    INVISIBLE_SEPARATOR = "\u2063"
    WORD_BOUNDARY = Regex.new("\b")
    NOT_WORD_BOUNDARY = Regex.new("[\u2063]*([\\\"'\\.,\\!\\@\\-\\:\\;\\$\\?\\(\\)\/])[\u2063]*")

    # replace word boundaries with 'invisible separator'
    # strip invisible separators from non-word boundaries
    # replace spaces or invisible separators with a single space
    # trim
    # split words on single space

    def self.tokenize(text)
      text.gsub(WORD_BOUNDARY, INVISIBLE_SEPARATOR)
        .gsub(NOT_WORD_BOUNDARY, "\\1")
        .gsub(/\x{2063}+/, " ")
        .gsub(/[ ]+/, " ")
        .strip
        .split(/[ ]+/)
    end
  end
end
