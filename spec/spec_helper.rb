module PitchBlurbs
  
  module TestMethods
    
    def parseMarkupLine(line)
      MarkupLineParser.new.parse(line)
    end
  
  end
end

RSpec.configure do |c|
  c.include PitchBlurbs::TestMethods
end
