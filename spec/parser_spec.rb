require 'pitch-blurb/parser'

module PitchBlurbs
  
  describe 'parse a marked-up line' do
    
    it "parses a marked-up line" do
      markedUpLine = ParsedMarkupLine.new("I *do not* like this: \\*\\*. _Give_ it to me")
      markedUpLine.components.should == ["I ", :start_bold, "do not", :end_bold, 
                                         " like this: ", "*", "*", ". ", 
                                         :start_italic, "Give", :end_italic, " it to me"]
    end
    
    it "parses nested bold and italic" do
      markedUpLine = ParsedMarkupLine.new("I *a_b_c*_d*e*f_")
      markedUpLine.components.should == ["I ", :start_bold, "a", :start_italic, "b", :end_italic, "c", :end_bold, 
                                         :start_italic, "d", :start_bold, "e", :end_bold, "f", :end_italic]
    end
    
    it "disallows 3 levels of nesting" do
      expect do
        markedUpLine = ParsedMarkupLine.new("I *a_b*c*d_e*")
      end.to raise_error ThreeLevelsMarkupParseException
    end      
    
    it "requires markup to be closed" do
      for line in ["*", "**_", "It _is good", "__*__*_"] do
        expect do
          markedUpLine = ParsedMarkupLine.new(line)
        end.to raise_error UnclosedMarkupException
      end
    end
      
  end
  
  describe 'parse a pitch blurb' do
    
    def readSourceFile(relativePath)
      File.open(File.join(File.dirname(__FILE__), relativePath)).read
    end
    
    it "parses a pitch blurb" do
      parser = PitchBlurbParser.new
      pitchBlurbSource = readSourceFile("input/frog.blurb")
      pitchBlurb = parser.parseBlurb(pitchBlurbSource)
      expectedPitchBlurb = Blurb.new(title: "My Frog", url: "frog.html", 
                                     blurb: "it eats flies", 
                                     lines: ["It jumps", "It's like a toad but not so ugly"])
      pitchBlurb.should == expectedPitchBlurb
    end
    
    it "parses two pitch blurbs" do
      parser = PitchBlurbParser.new
      pitchBlurbSource = readSourceFile("input/AandB.blurbs")
      pitchBlurbs = parser.parseBlurbs(pitchBlurbSource)
      expectedPitchBlurbs = [Blurb.new(title: "A", url: "a.html", blurb: "aye", lines:["A1", "A2", "A3"]), 
                             Blurb.new(title: "B", url: "b.html", blurb: "bee", lines:["B1", "B2"])]
      pitchBlurbs.should == expectedPitchBlurbs                        
    end
  end
end
