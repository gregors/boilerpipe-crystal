# Marks all TextBlocks "content" which are between the headline and the part that has
# already been marked content, if they are marked MIGHT_BE_CONTENT.
# This filter is quite specific to the news domain.
# used downstream of KeepLargetBlockFilter since that's what sets MIGHT_BE_CONTENT

module Boilerpipe::Filters
  class ExpandTitleToContentFilter
    def self.process(doc)
      tbs = doc.text_blocks

      i = 0
      title = nil
      content_start = -1

      tbs.each do |tb|
        title = i if content_start == -1 && tb.has_label?(:TITLE)
        content_start = i if content_start == -1 && tb.is_content?
        i += 1
      end

      return doc if no_title_with_subsequent_content?(content_start, title)
      title = 0 if title.nil?

      tbs[title...content_start].each do |tb|
        tb.content = true if tb.has_label?(:MIGHT_BE_CONTENT)
      end

      doc
    end

    def self.no_title_with_subsequent_content?(content_start, title)
      return title.nil? if title.nil?
      return true if content_start == -1
      return content_start <= title
    end
  end
end
