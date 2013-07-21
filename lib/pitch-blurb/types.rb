module PitchBlurbs
  
  class MarkedUpLine
    COMPONENT_HTML = { start_italic: "<i>", end_italic: "</i>", start_bold: "<b>", end_bold: "</b>"}
    
    attr_reader :components

    def initialize(*components)
      @components = []
      for component in components do
        add(component)
      end
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
    
    def ==(otherMarkedUpLine)
      otherMarkedUpLine.class == MarkedUpLine &&
        otherMarkedUpLine.components == @components
    end

    def to_html
      @components.map{|component| componentToHtml(component)}.join("")
    end
  end
  
  class Blurb
    attr_reader :title, :url, :blurb, :lines
    
    def markedUpLine(parameter)
      case parameter
      when MarkedUpLine
        parameter
      when String
        MarkedUpLine.new(parameter)
      else
        raise Exception("Parameter #{parameter.inspect} is not a MarkedUpLine and it's not a String")
      end
    end
    
    def initialize(attributes)
      @title = attributes[:title]
      @url = attributes[:url]
      @blurb = attributes[:blurb]
      @lines = attributes[:lines].map{|line| markedUpLine(line)}
    end
    
    def ==(otherPitchBlurb)
      otherPitchBlurb.class == Blurb &&
        otherPitchBlurb.title == @title &&
        otherPitchBlurb.url == @url &&
        otherPitchBlurb.blurb == @blurb &&
        otherPitchBlurb.lines == @lines
    end
    
    def to_html
      "<div class=\"blurb\">\n" +
        "  <a href=\"#{@url}\">\n" +
        "    <div class=\"title\">#{@title}</div><div class=\"heading\">#{@blurb}</div>\n" + 
        "    <div class=\"indenting\">\n" +
        @lines.map{|line| "      <p>#{line.to_html}</p>\n"}.join("") + 
        "    </div>\n" +
        "  </a>\n" +
        "</div>\n"
    end
  end
end
