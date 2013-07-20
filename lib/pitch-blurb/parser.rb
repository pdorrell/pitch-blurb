require 'pitch-blurb/types'

module PitchBlurbs
  
  class ParseException < Exception
  end

  class PitchBlurbParser
    
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
      Blurb.new(title: title, url: url, blurb: blurb, lines: lines[3..-1])
    end
    
    BLANK_LINES_REGEX = /(?:^[ \t]*(?:\r\n|\r|\n))+/m
    
    def parseBlurbs(source)
      lineGroups = source.split(BLANK_LINES_REGEX).select{|line| line != ""}
      lineGroups.map{|lines| parseBlurb(lines)}
    end
  end
end
