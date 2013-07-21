require 'pitch-blurb/parser'

module PitchBlurbs

  describe 'compile a marked-up line' do
    
    it "generates HTML markup for parsed marked-up line" do
      parser = MarkupLineParser.new
      markedUpLine = parser.parse("_This_ character _is_ an *asterisk*: \\*")
      html = markedUpLine.to_html
      html.should == "<i>This</i> character <i>is</i> an <b>asterisk</b>: *"
    end
    
    it "generates HTML markup for marked-up line" do
      markedUpLine = MarkedUpLine.new
      for component in [:start_italic, "Hello", " world", :end_italic] do
        markedUpLine.add(component)
      end
      markedUpLine.to_html.should == "<i>Hello world</i>"
    end
    
  end
end
  
