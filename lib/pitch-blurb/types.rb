module PitchBlurbs
  
  class Blurb
    attr_reader :title, :url, :blurb, :lines
    
    def initialize(attributes)
      @title = attributes[:title]
      @url = attributes[:url]
      @blurb = attributes[:blurb]
      @lines = attributes[:lines]
    end
    
    def ==(otherPitchBlurb)
      otherPitchBlurb.class == Blurb &&
        otherPitchBlurb.title == @title &&
        otherPitchBlurb.url == @url &&
        otherPitchBlurb.blurb == @blurb &&
        otherPitchBlurb.lines == @lines
    end
  end
end
