module PitchBlurbs
  
  class MarkedUpLine
    COMPONENT_HTML = { start_italic: "<i>", end_italic: "</i>", start_bold: "<b>", end_bold: "</b>"}
    
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

    def componentToHtml(component)
      case component
      when Symbol
        COMPONENT_HTML[component]
      else
        component
      end
    end

    def to_html
      @components.map{|component| componentToHtml(component)}.join("")
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
