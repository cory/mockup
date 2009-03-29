#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

require "#{File.dirname(__FILE__)}/../testing_file_support"

describe BalsamiqControlParser do
  it "properly handles checkbox" do
    data = <<-EOF
            <mockup version="1.0" skin="sketch">
      <controls>
        <control controlID="4" controlTypeID="com.balsamiq.mockups::CheckBox" x="96" y="37" w="-1" h="-1" zOrder="0" locked="false" isInGroup="-1">
          <controlProperties>
            <text>Checkbox</text>
          </controlProperties>
        </control>
        <control controlID="5" controlTypeID="com.balsamiq.mockups::CheckBox" x="96" y="55" w="199" h="39" zOrder="1" locked="false" isInGroup="-1">
          <controlProperties>
            <text>Another%20checkbox</text>
          </controlProperties>
        </control>
      </controls>
    </mockup>


    EOF
    html = <<-EOF
    <?xml version="1.0" encoding="UTF-8"?>
<!-- Generated by Balsamiq Exporter -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="reset.css" />
    <title>Balsamiq</title>
    <script type="text/javascript">
    </script>
  </head>

  <body>
    <div class="CheckBox" id="CheckBox4" 
          style="position: absolute; left: 96px; top: 37px; z-index: ;
          font-size:10pt; color: #010101; outline: none; background-color: transparent;">
      <input type="checkbox" id="CheckBox4checkbox">
      <label for="CheckBox4checkbox">Checkbox</label>
    </div>
    <div class="CheckBox" id="CheckBox5" 
          style="position: absolute; left: 96px; top: 55px; z-index: ;
          font-size:10pt; color: #010101; outline: none; background-color: transparent;">
      <input type="checkbox" id="CheckBox5checkbox">
      <label for="CheckBox5checkbox">Another checkbox</label>
    </div>
  </body>
</html>

    EOF
    css = <<-EOF

    EOF
    js = <<-EOF

    EOF
    filename = "checkbox"
    TestingFileSupport::test_elements(filename, data, html, css, js, false)
  end

end
