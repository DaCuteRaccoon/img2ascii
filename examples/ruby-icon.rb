#!/usr/bin/env ruby

require 'rubygems'
require '../lib/img2ascii.rb'

ascii = ASCII_Image.new("ruby.png")
ascii.build(80)
