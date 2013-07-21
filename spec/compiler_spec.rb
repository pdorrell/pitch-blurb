require 'pitch-blurb/parser'

module PitchBlurbs

  describe 'compile a marked-up line' do
    
    it "generates HTML markup for marked-up line" do
      markedUpLine = ParsedMarkupLine.new("_This_ character _is_ an *asterisk*: \\*")
      html = markedUpLine.to_html
      html.should == "<i>This</i> character <i>is</i> an <b>asterisk</b>: *"
    end
  end
end
  
