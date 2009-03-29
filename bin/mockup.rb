#!/usr/bin/env ruby	

# mockupexport
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

require "#{File.dirname(__FILE__)}/../lib/balsamiq/control"
require "#{File.dirname(__FILE__)}/../lib/balsamiq/controlparser"
require "#{File.dirname(__FILE__)}/../lib/balsamiq/options"


options = MockupOptions.new(ARGV)

basename = options.basename
filename = ".temp.xml"

if options.pasteboard
  File.open("#{filename}","w"){|file| file.puts `pbpaste` }
else
  filename = options.sourcefile
end

parser = BalsamiqControlParser.new

parser.process_balsamiq("#{filename}", "#{basename}", "html")

File.delete("#{filename}") if filename == ".temp.xml"
