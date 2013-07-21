require 'pitch-blurb/parser'
require 'spec_helper'

module PitchBlurbs

  describe 'compile a marked-up line' do
    
    it "generates HTML markup for parsed marked-up line" do
      parser = MarkupLineParser.new
      markedUpLine = parser.parse("_This_ character _is_ an *asterisk*: \\*")
      markedUpLine.should == MarkedUpLine.new(:start_italic, "This", :end_italic, 
                                              " character ", 
                                              :start_italic, "is", :end_italic, 
                                              " an ", 
                                              :start_bold, "asterisk", :end_bold, 
                                              ": *")
      html = markedUpLine.to_html
      html.should == "<i>This</i> character <i>is</i> an <b>asterisk</b>: *"
    end
    
    it "generates HTML markup for marked-up line" do
      markedUpLine = MarkedUpLine.new(:start_italic, "Hello", " world", :end_italic)
      markedUpLine.to_html.should == "<i>Hello world</i>"
    end
    
    it "generates HTML markup for parsed blurb" do
      pitchBlurbSource = readSourceFile("input/frog.blurb")
      parser = PitchBlurbParser.new
      pitchBlurb = parser.parseBlurb(pitchBlurbSource)
      expectedHtml = readSourceFile("output/frog-blurb.html")
      pitchBlurb.to_html.should == expectedHtml
    end

    it "generates HTML markup for parsed blurbs" do
      pitchBlurbSource = readSourceFile("input/AandB.blurbs")
      parser = PitchBlurbParser.new
      pitchBlurbs = parser.parseBlurbs(pitchBlurbSource)
      expectedHtml = readSourceFile("output/AandB-blurbs.html")
      pitchBlurbs.map(&:to_html).join.should == expectedHtml
    end
  end
end
  
