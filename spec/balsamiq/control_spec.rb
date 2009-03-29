#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

unless Object.const_defined?("BalsamiqControl")
  require "#{File.dirname(__FILE__)}/../../lib/balsamiq/control"
  require "#{File.dirname(__FILE__)}/../../lib/symbols/balsamiq-control-symbols"
end

describe BalsamiqControl do
  it "should correctly convert balsamiq integer colors to rgba(r,g,b,a) format" do
    BalsamiqControl.bcolor2web(798196).should == "rgba(12,45,244,1.0)"
    BalsamiqControl.bcolor2web(11764).should == "rgba(0,45,244,1.0)"
    BalsamiqControl.bcolor2web(0).should == "rgba(0,0,0,1.0)"
    BalsamiqControl.bcolor2web(16723200).should == "rgba(255,45,0,1.0)"
  end

  BalsamiqControlSymbols.each do |sym|
    it "#{sym} should have a default size" do
      BalsamiqControl::CONTROL_SIZE_DEFAULTS[sym].should_not == nil
    end
  end
end
