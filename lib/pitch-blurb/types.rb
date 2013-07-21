module PitchBlurbs
  
  class MarkedUpLine
    attr_reader :components
    def initialize
      @components = []
    end
    
    def add(component)
      case component
      when Symbol
        @components << component
      when String
        if @components.length > 0 && @components[-1].class == String
          @components[-1] += component
        else
          @components << component
        end
      end
    end
  end
  
  class Blurb
    attr_reader :title, :url, :blurb, :lines
    
    def initialize(attributes)
      @title = attributes[:title]
      @url = attributes[:url]
      @blurb = attributes[:blurb]
      @lines = attributes[:lines]
    end
    
    def ==(otherPitchBlurb)
      otherPitchBlurb.class == Blurb &&
        otherPitchBlurb.title == @title &&
        otherPitchBlurb.url == @url &&
        otherPitchBlurb.blurb == @blurb &&
        otherPitchBlurb.lines == @lines
    end
  end
end
