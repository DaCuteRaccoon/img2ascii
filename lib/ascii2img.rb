#!/usr/bin/env ruby

require 'rubygems'
require 'rmagick'
require 'rainbow'
require 'open-uri'

class ASCII_Image
  # Initialize class
  # There will be an error if ImageMagick quantum depth > 8
  
  def initialize(uri, console_width = 80)
    @uri = uri
    @console_width = console_width
    @quantum_conversion_factor = 1
    
    if Magick::MAGICKCORE_QUANTUM_DEPTH > 16
      raise "Your ImageMagick quantum depth is set to #{Magick::MAGICKCORE_QUANTUM_DEPTH}. You need to have it set to 8 in order for this app to work."
    elsif Magick::MAGICKCORE_QUANTUM_DEPTH == 16
      @quantum_conversion_factor = 257
    end
  end
  
  # Convert image to ASCII and print to console
  
  def build(width)
    resource = open(@uri)
    image = Magick::ImageList.new
    image.from_blob resource.read
    
    if width > @console_width
      raise ArgumentError, "The desired width is bigger than the console width"
    end
    
    image = image.scale(width / image.columns.to_f)
    image = image.scale(image.columns, image.rows / 1.7)
    
    image.each_pixel do |pixel, col, row|
      print Rainbow(" ").background(pixel.red/@quantum_conversion_factor, pixel.green/@quantum_conversion_factor, pixel.blue/@quantum_conversion_factor)
      
      if (col % (width - 1) == 0) and (col != 0)
        print "\n"
      end
    end
  end
end
