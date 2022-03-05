#!/usr/bin/env ruby

require 'rubygems'
require '../lib/img2ascii.rb'

ascii = ASCII_Image.new("ruby.jpg")
ascii.build(80)
