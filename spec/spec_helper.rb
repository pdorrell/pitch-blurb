module PitchBlurbs
  
  module TestMethods
    
    def parseMarkupLine(line)
      MarkupLineParser.new.parse(line)
    end
  
    def readSourceFile(relativePath)
      File.open(File.join(File.dirname(__FILE__), relativePath)).read
    end
    
  end
end

RSpec.configure do |c|
  c.include PitchBlurbs::TestMethods
end
