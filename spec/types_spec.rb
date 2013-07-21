require 'pitch-blurb/types'

module PitchBlurbs
  
  describe 'marked up line' do
    
    it "construct & deconstruct markup line" do
      markedUpLine = MarkedUpLine.new
      markedUpLine.add(:start_italic)
      markedUpLine.add("Hello")
      markedUpLine.add(" world")
      markedUpLine.add(:end_italic)
      markedUpLine.components.should == [:start_italic, "Hello world", :end_italic]
    end
    
    it "constructs with or without initial components" do
      markedUpLine = MarkedUpLine.new("Hello ", "world")
      markedUpLine2 = MarkedUpLine.new
      markedUpLine2.add("Hello ")
      markedUpLine2.add("world")
      markedUpLine.should == markedUpLine2
    end
    
  end
  
  describe 'pitch blurb type' do
    
    it "construct & deconstruct pitch blurb" do
      pitchBlurb = Blurb.new(title: "My Frog", url: "frog.html", 
                             blurb: "it eats flies", lines: ["It jumps", "It's like a toad but not so ugly"])
      pitchBlurb.title.should == "My Frog"
      pitchBlurb.url.should == "frog.html"
      pitchBlurb.blurb.should == "it eats flies"
      pitchBlurb.lines[0].should == MarkedUpLine.new("It jumps")
    end
    
    it "is equal to pitch blurb with same attributes" do
      pitchBlurb1 = Blurb.new(title: "Frog", url: "f.html", blurb: "ribbit", lines: ["line1", "line2"])
      pitchBlurb2 = Blurb.new(title: "Frog", url: "f.html", blurb: "ribbit", lines: [MarkedUpLine.new("line1"), 
                                                                                     "line2"])
      pitchBlurb1.should_not == "a string"
      pitchBlurb1.should == pitchBlurb2
      pitchBlurb1.should_not == Blurb.new(title: "Toad", url: "f.html", blurb: "ribbit", lines: ["line1", "line2"])
      pitchBlurb1.should_not == Blurb.new(title: "Frog", url: "g.html", blurb: "ribbit", lines: ["line1", "line2"])
      pitchBlurb1.should_not == Blurb.new(title: "Frog", url: "f.html", blurb: "robbit", lines: ["line1", "line2"])
      pitchBlurb1.should_not == Blurb.new(title: "Frog", url: "f.html", blurb: "ribbit", lines: ["line1"])
    end
  end
end
