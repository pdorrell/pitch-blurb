module PitchBlurbs

  class Blurb
    attr_reader :title, :url, :blurb, :lines
    
    def initialize(attributes)
      @title = attributes[:title]
      @url = attributes[:url]
      @blurb = attributes[:blurb]
      @lines = attributes[:lines]
    end
  end
end
