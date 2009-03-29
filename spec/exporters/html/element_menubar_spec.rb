#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

require "#{File.dirname(__FILE__)}/../testing_file_support"

describe BalsamiqControlParser do
  it "properly handles menubar" do
    data = <<-EOF
            <mockup version="1.0" skin="sketch">
      <controls>
        <control controlID="2" controlTypeID="com.balsamiq.mockups::MenuBar" x="47" y="12" w="-1" h="-1" zOrder="0" locked="false" isInGroup="-1">
          <controlProperties>
            <text>File%2CEdit%2CView%2CHelp</text>
          </controlProperties>
        </control>
        <control controlID="3" controlTypeID="com.balsamiq.mockups::MenuBar" x="47" y="52" w="-1" h="-1" zOrder="1" locked="false" isInGroup="-1">
          <controlProperties>
            <text>File%2CEdit%2CView%2CHelp%2Cbar%2Cdoom</text>
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
      <link rel="stylesheet" type="text/css" href="menubar.css" />
    <title>Balsamiq</title>
    <script type="text/javascript">
    </script>
  </head>

  <body>
    <div class="MenuBar" id="MenuBar2";
        style="position: absolute; left: 47px; top: 12px; height: 25px;
        z-index: 0;">
        <span>File</span><span>Edit</span><span>View</span><span>Help</span>
    </div>
    <div class="MenuBar" id="MenuBar3";
        style="position: absolute; left: 47px; top: 52px; height: 25px;
        z-index: 1;">
        <span>File</span><span>Edit</span><span>View</span><span>Help</span><span>bar</span><span>doom</span>
    </div>
  </body>
</html>

    EOF
    css = <<-EOF
    .MenuBar span {
  margin: 12px; 
  font-size: 14px;
}

    EOF
    js = <<-EOF

    EOF
    filename = "menubar"
    TestingFileSupport::test_elements(filename, data, html, css, js, false)
  end

end
