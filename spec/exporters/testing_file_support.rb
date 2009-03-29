#!/usr/bin/env ruby	

# test_support
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

unless Object.const_defined?("BalsamiqControl")
  require "#{File.dirname(__FILE__)}/../../lib/balsamiq/control"
end

unless Object.const_defined?("BalsamiqControlParser")
  require "#{File.dirname(__FILE__)}/../../lib/balsamiq/controlparser"
end

unless Object.const_defined?("BalsamiqControlSymbols")
  require "#{File.dirname(__FILE__)}/../../lib/symbols/balsamiq-control-symbols"
end

require "#{File.dirname(__FILE__)}/../../lib/exporters/balsamiq2html"

module TestingFileSupport
  def self.comparelinebyline(test, filename)
    ta = test.split("\n")
    count = 0
    File.open(filename) do |file|
      file.each do |line| 
        if ta[count] == nil
          if line.strip != ""
            return filename + " mismatch line:#{count} #{filename}:#{line} data:#{ta[count]}"
          end
        elsif line.strip != ta[count].strip
          return filename + " mismatch line:#{count} #{filename}:#{line} data:#{ta[count]}"
        else
          count += 1
        end
      end
    end
    filename
  end

  def self.test_elements(filename, data, html, css, js, keep = false)
    File.open("#{filename}.xml", "w") {|file| file.puts data }
    @balsamiqcontrolparser = BalsamiqControlParser.new
    @balsamiqcontrolparser.process_balsamiq("#{filename}.xml", "#{filename}", "html")
    File.exists?("#{filename}.html").should == true

    if File.exists?("#{filename}.js")
      comparelinebyline(js, "#{filename}.js").should == "#{filename}.js"
    end

    if File.exists?("#{filename}.css")
      comparelinebyline(css, "#{filename}.css").should == "#{filename}.css"
    end

    comparelinebyline(html, "#{filename}.html").should == "#{filename}.html"

    unless keep
      File.delete("#{filename}.html").should == 1
      File.delete("#{filename}.xml").should == 1
      if File.exists?("#{filename}.js")
        File.delete("#{filename}.js").should == 1
      end

      if File.exists?("#{filename}.css")
        File.delete("#{filename}.css").should == 1
      end
    end
  end
end
