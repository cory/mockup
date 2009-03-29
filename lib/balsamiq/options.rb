#!/usr/bin/env ruby	

# options
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

require 'optparse'

class MockupOptions
  DEFAULT_BASENAME = "balsamiq"
  attr_reader :basename
  attr_reader :pasteboard
  attr_reader :sourcefile
  def initialize(argv)
    @basename = DEFAULT_BASENAME
    @pasteboard = true
    @sourcefile = nil
    parse(argv)
  end
  
  def test(val)
    [:basename => @basename, :pasteboard => @pasteboard, :sourcefile => @sourcefile] == val
  end
  
  private
  def parse(argv)
    OptionParser.new do |opts|
      opts.banner = "Usage: mockup [ options ]"
      
      opts.on("-p", "--pasteboard", "Use pasteboard rather than file") do |pb|
        @pasteboard = true
      end
      
      opts.on("-n", "--name [basename]", String, "Basename for files created by exporter") do |basename|
        @basename = basename
      end
      
      opts.on("-s", "--source [filename]", String, "File to use rather than pasteboard") do |sourcefile|
        @sourcefile = sourcefile
        @pasteboard = false
      end
      
      opts.on("-h", "--help", "You're looking at it") do
        puts opts
        exit
      end
      
      argv = ["-p"] if argv.empty?
      begin
        opts.parse!(argv)
      rescue OptionParser::ParseError => e
        STDERR.puts e.message, "\n", opts
        exit(1)
      end
    end
  end
end
