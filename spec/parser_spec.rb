require 'pitch-blurb/parser'

module PitchBlurbs
  
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
