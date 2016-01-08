# TextBodyTokenizer splits an incoming text body up into a marker
# abbreviation and a value. Valid incoming texts are in the format of:
# abbreviation : or | or - or whitespace value
class TextBodyTokenizer
  SPLIT_REGEX = /^(\w+)\s*(:+|-+|\s+|\|+)\s*(\S+)/

  attr_reader :text_body

  def initialize(text_body)
    @text_body = text_body
  end

  def marker_abbreviation
    matches[1].downcase.strip
  end

  def marker_value
    matches[3].strip
  end

  private

  def matches
    @matches ||= text_body.match(SPLIT_REGEX)
  end
end
