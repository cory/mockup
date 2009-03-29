#!/usr/bin/env ruby	

# options-spec
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

require "#{File.dirname(__FILE__)}/../../lib/balsamiq/options"

MockupOptionHelp = <<-EOF
Usage: mockup [ options ]
    -p, --pasteboard                 Use pasteboard rather than file
    -n, --name [basename]            Basename for files created by exporter
    -s, --source [filename]          File to use rather than pasteboard
    -h, --help                       You're looking at it
EOF

describe MockupOptions do
  it "should default to pasteboard, basename balsamiq" do
    MockupOptions.new([]).test([:basename => "balsamiq", :pasteboard => true, :sourcefile => nil]).should == true
  end
  
  it "should read from the pasteboard when the pasteboard option exists" do
    MockupOptions.new(["-p"]).test([:basename => "balsamiq", :pasteboard => true, :sourcefile => nil]).should == true
    MockupOptions.new(["--pasteboard"]).test([:basename => "balsamiq", :pasteboard => true, :sourcefile => nil]).should == true
  end

  it "should print out help when help is requested or not input" do
    begin
      MockupOptions.new(["-h"])
    rescue SystemExit => e
      e.status.should == 0
    end
    begin
      MockupOptions.new(["--help"])
    rescue SystemExit => e
      e.status.should == 0
    end
  end

  it "should handle junk input" do
    begin
      MockupOptions.new(["-this is -junky junk"]).should == true
    rescue SystemExit => e
      e.status.should == 1
    end
  end
  
  it "should default to pasteboard, and allow the basename to be changed" do
    MockupOptions.new(["-n", "foo"]).test([:basename => "foo", :pasteboard => true, :sourcefile => nil]).should == true
    MockupOptions.new(["--name","foo"]).test([:basename => "foo", :pasteboard => true, :sourcefile => nil]).should == true
  end

  it "should deactivate the pasteboard if given a source file" do
    MockupOptions.new(["-s","bar"]).test([:basename => "balsamiq", :pasteboard => false, :sourcefile => "bar"]).should == true
    MockupOptions.new(["--source", "bar"]).test([:basename => "balsamiq", :pasteboard => false, :sourcefile => "bar"]).should == true
  end

  it "should deactivate the pasteboard if given a source file and a basename" do
    MockupOptions.new(["-s", "bar", "-n", "foo"]).test([:basename => "foo", :pasteboard => false, :sourcefile => "bar"]).should == true
    MockupOptions.new(["--source", "bar", "--name", "foo"]).test([:basename => "foo", :pasteboard => false, :sourcefile => "bar"]).should == true
    MockupOptions.new(["-s", "bar", "--name", "foo"]).test([:basename => "foo", :pasteboard => false, :sourcefile => "bar"]).should == true
    MockupOptions.new(["--source", "bar", "-n", "foo"]).test([:basename => "foo", :pasteboard => false, :sourcefile => "bar"]).should == true
  end
end
