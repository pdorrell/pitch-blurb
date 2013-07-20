require 'pitch-blurb/parser'

module PitchBlurbs
  
  describe 'parse a pitch blurb' do
    
    it "parses a pitch blurb" do
      parser = PitchBlurbParser.new
      pitchBlurbSource = File.open(File.join(File.dirname(__FILE__), "input/frog.blurb")).read
      pitchBlurb = parser.parseBlurb(pitchBlurbSource)
      expectedPitchBlurb = Blurb.new(title: "My Frog", url: "frog.html", 
                                     blurb: "it eats flies", 
                                     lines: ["It jumps", "It's like a toad but not so ugly"])
      pitchBlurb.should == expectedPitchBlurb
    end
  end
end
