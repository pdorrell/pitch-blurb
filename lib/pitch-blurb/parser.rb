require 'pitch-blurb/types'

module PitchBlurbs
  
  class ParseException < Exception
  end
  
  class ThreeLevelsMarkupParseException < ParseException
    def initialize(line)
      super("Only two levels of nesting allowed for * and _ : #{line.inspect}")
    end
  end
  
  class UnclosedMarkupException < ParseException
    def initialize(markups, line)
      super("Unclosed markups #{markups.inspect} at end of line: #{line.inspect}")
    end
  end
  
  # A line consisting of text or markers for :start_italic :end_italic :start_bold :end_bold from "_" and "*"
  # Allow backslash quoting
  class MarkupLineParser
    attr_reader :components
    
    MARKUP_REGEX = /([\\].)|([*_])|([^\\*_]+)/
    
    START_COMPONENTS = {"_" => :start_italic, "*" => :start_bold}
    END_COMPONENTS = {"_" => :end_italic, "*" => :end_bold}
    
    def parse(line)
      scannedLine = line.scan(MARKUP_REGEX)
      markedUpLine = MarkedUpLine.new
      @components = []
      markupStack = []
      for scanItem in scannedLine do
        if scanItem[0] # quoted character
          markedUpLine.add(scanItem[0][1])
        elsif scanItem[2] # plain text
          markedUpLine.add(scanItem[2])
        elsif scanItem[1] # markup _ or *
          markup = scanItem[1]
          if markupStack.length == 0
            markedUpLine.add(START_COMPONENTS[markup])
            markupStack << markup
          elsif markupStack.length == 1
            if markup == markupStack[-1]
              markupStack.pop
              markedUpLine.add(END_COMPONENTS[markup])
            else
              markupStack << markup
              markedUpLine.add(START_COMPONENTS[markup])
            end
          elsif markupStack.length == 2
            if markup == markupStack[-1]
              markupStack.pop
              markedUpLine.add(END_COMPONENTS[markup])
            else
              raise ThreeLevelsMarkupParseException.new(line)
            end
          end
        end
      end
      if !markupStack.empty?
        raise UnclosedMarkupException.new(markupStack,line)
      end
      markedUpLine
    end
  end
  
  class PitchBlurbParser
    
    def initialize
      @markupLineParser = MarkupLineParser.new
    end
    
    def getNamedLineValue(name, line)
      namePrefix = name + ":"
      if line.start_with?(namePrefix)
        line[namePrefix.length..-1].strip
      else
        raise ParseException.new("Line #{line.inspect} does not start with #{namePrefix.inspect}")
      end
    end
    
    def parseBlurb(source)
      lines = source.split("\n").map{ |line| line.strip}.select{ |line| line != ""}
      if lines.length < 4
        raise ParseException.new("Less than four lines")
      end
      title = getNamedLineValue("title", lines[0])
      url = getNamedLineValue("url", lines[1])
      blurb = getNamedLineValue("blurb", lines[2])
      Blurb.new(title: title, url: url, blurb: blurb, 
                lines: lines[3..-1].map{|line| @markupLineParser.parse(line)})
    end
    
    BLANK_LINES_REGEX = /(?:^[ \t]*(?:\r\n|\r|\n))+/m
    
    def parseBlurbs(source)
      lineGroups = source.split(BLANK_LINES_REGEX).select{|line| line != ""}
      lineGroups.map{|lines| parseBlurb(lines)}
    end
  end
end
