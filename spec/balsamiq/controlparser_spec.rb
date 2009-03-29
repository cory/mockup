#!/usr/bin/env ruby	

# controlparser-spec
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


unless Object.const_defined?("BalsamiqControl")
  require "#{File.dirname(__FILE__)}/../../lib/balsamiq/control"
end
unless Object.const_defined?("BalsamiqControlSymbols")
  require "#{File.dirname(__FILE__)}/../../lib/symbols/balsamiq-control-symbols"
end
require "#{File.dirname(__FILE__)}/../../lib/balsamiq/controlparser"
require "#{File.dirname(__FILE__)}/../../lib/symbols/balsamiq-symbol-dump"

TestHeader = 
%Q{<mockup version="1.0" skin="sketch">
  <controls>
}

TestFooter = 
%Q{  </controls>
</mockup>
}

describe BalsamiqControlParser do
  before :all do
    BalsamiqControlSymbols.each do |sym|
      File.open("BalsamiqTestXML#{sym}.xml", "w") {|file| file.puts eval "TestHeader + BalsamiqTestXML#{sym} + TestFooter" }
    end
  end

  after :all do
    BalsamiqControlSymbols.each do |sym|
      File.delete("BalsamiqTestXML#{sym}.xml")
    end
  end

  it "should open BalsamiqTestXML#{BalsamiqControlSymbols[0]}.xml" do
    @balsamiqcontrolparser = BalsamiqControlParser.new
    @balsamiqcontrolparser.load_file("BalsamiqTestXML#{BalsamiqControlSymbols[0]}.xml").should_not == nil
  end

  it "should raise an exception if no file read" do
    @balsamiqcontrolparser = BalsamiqControlParser.new
    @balsamiqcontrolparser.load_file("").should raise_error
  end


  BalsamiqControlSymbols.each do |sym|
    it "should open, read, and close every #{sym}, confirming that data is read properly" do
      @balsamiqcontrolparser = BalsamiqControlParser.new
      @balsamiqcontrolparser.load_file("BalsamiqTestXML#{sym}.xml")
      @balsamiqcontrolparser.xml.should == (eval "TestHeader + BalsamiqTestXML#{sym} + TestFooter")
    end
  end

  BalsamiqControlSymbols.each do |sym|
    it "should open, read, and close #{sym}, confirming that version is 1.0" do
      @balsamiqcontrolparser = BalsamiqControlParser.new
      @balsamiqcontrolparser.load_file("BalsamiqTestXML#{sym}.xml")
      @balsamiqcontrolparser.xml_parse
      @balsamiqcontrolparser.get_balsamiq_version.should == "1.0"
    end
  end

  BalsamiqControlSymbols.each do |sym|
    it "#{sym} element should be parsed correctly" do
      @balsamiqcontrolparser = BalsamiqControlParser.new
      @balsamiqcontrolparser.load_file("BalsamiqTestXML#{sym}.xml")
      @balsamiqcontrolparser.xml_parse
      @balsamiqcontrolparser.get_all_elements
      eval "@balsamiqcontrolparser[0].test(BalsamiqTestData#{sym}).should == true"
    end
  end

  BalsamiqControlSymbols.each do |sym|
    it "#{sym} element should be parsed correctly" do
      @balsamiqcontrolparser = BalsamiqControlParser.new
      @balsamiqcontrolparser.load_file("BalsamiqTestXML#{sym}.xml")
      @balsamiqcontrolparser.xml_parse
      @balsamiqcontrolparser.get_all_elements
      eval "JSON(@balsamiqcontrolparser[0].to_json).should == JSON(BalsamiqTestData#{sym}.to_json)"
    end
  end

  it "should have a clean single call to use balsamiq-all-controls.xml to build " do
    @balsamiqcontrolparser = BalsamiqControlParser.new
    @balsamiqcontrolparser.process_examples("BalsamiqTestXML#{BalsamiqControlSymbols[0]}.xml", "temp")
    File.exists?("#{File.dirname(__FILE__)}/../../lib/symbols/temp-defaults.rb").should == true
    File.exists?("#{File.dirname(__FILE__)}/../../lib/symbols/temp-symbols.rb").should == true
    File.delete("#{File.dirname(__FILE__)}/../../lib/symbols/temp-defaults.rb").should == 1
    File.delete("#{File.dirname(__FILE__)}/../../lib/symbols/temp-symbols.rb").should == 1
  end
end
