require 'pitch-blurb/types'

module PitchBlurbs
  
  describe 'pitch blurb type' do
    
    it "construct & deconstruct pitch blurb" do
      pitchBlurb = Blurb.new(title: "My Frog", url: "frog.html", 
                             blurb: "it eats flies", lines: ["It jumps", "It's like a toad but not so ugly"])
      pitchBlurb.title.should == "My Frog"
    end
  end
end
