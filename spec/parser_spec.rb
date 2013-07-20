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
  end
end
