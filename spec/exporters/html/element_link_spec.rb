#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

require "#{File.dirname(__FILE__)}/../testing_file_support"

describe BalsamiqControlParser do
  it "properly handles link" do
    data = <<-EOF
            <mockup version="1.0" skin="sketch">
      <controls>
        <control controlID="16" controlTypeID="com.balsamiq.mockups::Link" x="87" y="64" w="-1" h="-1" zOrder="1" locked="false" isInGroup="-1">
          <controlProperties>
            <text>another%2C%20longer%20link</text>
          </controlProperties>
        </control>
        <control controlID="15" controlTypeID="com.balsamiq.mockups::Link" x="67" y="26" w="-1" h="-1" zOrder="0" locked="false" isInGroup="-1">
          <controlProperties>
            <text>a%20link</text>
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
    <div class="Link" id="Link16";
        style="position: absolute; left: 87px; top: 64px; font-size: 9pt; text-align: center;
        z-index: 1; outline: none; background-color: transparent; color: #010101;">
        <a href=""><b>another, longer link</b></a>
    </div>
    <div class="Link" id="Link15";
        style="position: absolute; left: 67px; top: 26px; font-size: 9pt; text-align: center;
        z-index: 0; outline: none; background-color: transparent; color: #010101;">
        <a href=""><b>a link</b></a>
    </div>
  </body>
</html>

    EOF
    css = <<-EOF

    EOF
    js = <<-EOF

    EOF
    filename = "link"
    TestingFileSupport::test_elements(filename, data, html, css, js, false)
  end

end