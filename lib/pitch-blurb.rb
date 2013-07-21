require 'pitch-blurb/parser'

module PitchBlurbs
  def self.compileBlurb(blurbSource)
    pitchBlurb = PitchBlurbParser.new.parseBlurb(blurbSource)
    pitchBlurb.to_html
  end
  
  def self.compileBlurbs(blurbSource)
    pitchBlurbs = PitchBlurbParser.new.parseBlurbs(blurbSource)
    pitchBlurbs.map(&:to_html).join
  end
    
end
