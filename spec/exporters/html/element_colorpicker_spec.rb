#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

require "#{File.dirname(__FILE__)}/../testing_file_support"

describe BalsamiqControlParser do
  it "properly handles colorpicker" do
    data = <<-EOF
            <mockup version="1.0" skin="sketch">
      <controls>
        <control controlID="17" controlTypeID="com.balsamiq.mockups::ColorPicker" x="93" y="35" w="-1" h="-1" zOrder="0" locked="false" isInGroup="-1">
          <controlProperties>
            <color>16711680</color>
          </controlProperties>
        </control>
        <control controlID="18" controlTypeID="com.balsamiq.mockups::ColorPicker" x="131" y="34" w="-1" h="-1" zOrder="1" locked="false" isInGroup="-1"/>
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
    <div class="ColorPicker" id="ColorPicker17" 
          style="position: absolute; left: 93px; top: 35px; width: 26px; height: 28px; z-index: ;
          font-size:10pt; color: #010101; background-color: rgba(255,0,0,1.0);">
      <div class="ColorPicker" id="ColorPicker17" 
            style="position: relative; left: 10.4px; top: 19.6px; z-index: ;
            font-size:10pt; color: #010101; background-color: transparent; outline: none;">
            \\/
      </div>
    </div>
    <div class="ColorPicker" id="ColorPicker18" 
          style="position: absolute; left: 131px; top: 34px; width: 26px; height: 28px; z-index: ;
          font-size:10pt; color: #010101; background-color: #0101ff;">
      <div class="ColorPicker" id="ColorPicker18" 
            style="position: relative; left: 10.4px; top: 19.6px; z-index: ;
            font-size:10pt; color: #010101; background-color: transparent; outline: none;">
            \\/
      </div>
    </div>
  </body>
</html>

    EOF
    css = <<-EOF

    EOF
    js = <<-EOF

    EOF
    filename = "colorpicker"
    TestingFileSupport::test_elements(filename, data, html, css, js, false)
  end

end
