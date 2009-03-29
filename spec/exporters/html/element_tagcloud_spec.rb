#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

require "#{File.dirname(__FILE__)}/../testing_file_support"

describe BalsamiqControlParser do
  it "properly handles tagcloud" do
    data = <<-EOF
            <mockup version="1.0" skin="sketch">
      <controls>
        <control controlID="37" controlTypeID="com.balsamiq.mockups::TagCloud" x="70" y="70" w="-1" h="-1" zOrder="0" locked="false" isInGroup="-1">
          <controlProperties>
            <text>software%20statistics%20teaching%20technology%20tips%20tool%20tools%20toread%20travel%20tutorial%20tutorials%20tv%20twitter%20typography%20ubuntu%20usability%20video%20videos%20visualization%20web%20web2.0%20webdesign%20webdev%20wiki%20windows%20wordpress%20work%20writing%20youtube</text>
          </controlProperties>
        </control>
        <control controlID="38" controlTypeID="com.balsamiq.mockups::TagCloud" x="435" y="13" w="224" h="412" zOrder="1" locked="false" isInGroup="-1">
          <controlProperties>
            <text>software%20statistics%20teaching%20technology%20tips%20tool%20tools%20toread%20travel%20tutorial%20tutorials%20tv%20twitter%20typography%20ubuntu%20usability%20video%20videos%20visualization%20web%20web2.0%20webdesign%20webdev%20wiki%20windows%20wordpress%20work%20writing%20youtube</text>
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
        <div class="TagCloud" id="TagCloud37"
              style="position: absolute; left: 70px; top: 70px; height: 250px; width: 350px; z-index: 
              0; overflow: hidden; outline: none; background-color: transparent">
    <span style='font-size: 36px;'>software</span> <span style='font-size: 20px;'>statistics</span> <span style='font-size: 32px;'>teaching</span> <span style='font-size: 28px;'>technology</span> <span style='font-size: 24px;'>tips</span> <span style='font-size: 24px;'>tool</span> <span style='font-size: 8px;'>tools</span> <span style='font-size: 12px;'>toread</span> <span style='font-size: 36px;'>travel</span> <span style='font-size: 12px;'>tutorial</span> <span style='font-size: 36px;'>tutorials</span> <span style='font-size: 12px;'>tv</span> <span style='font-size: 16px;'>twitter</span> <span style='font-size: 32px;'>typography</span> <span style='font-size: 20px;'>ubuntu</span> <span style='font-size: 32px;'>usability</span> <span style='font-size: 24px;'>video</span> <span style='font-size: 24px;'>videos</span> <span style='font-size: 16px;'>visualization</span> <span style='font-size: 32px;'>web</span> <span style='font-size: 16px;'>web2.0</span> <span style='font-size: 8px;'>webdesign</span> <span style='font-size: 8px;'>webdev</span> <span style='font-size: 24px;'>wiki</span> <span style='font-size: 28px;'>windows</span> <span style='font-size: 8px;'>wordpress</span> <span style='font-size: 12px;'>work</span> <span style='font-size: 36px;'>writing</span> <span style='font-size: 32px;'>youtube</span></div>    <div class="TagCloud" id="TagCloud38"
              style="position: absolute; left: 435px; top: 13px; height: 412px; width: 224px; z-index: 
              1; overflow: hidden; outline: none; background-color: transparent">
    <span style='font-size: 32px;'>software</span> <span style='font-size: 36px;'>statistics</span> <span style='font-size: 16px;'>teaching</span> <span style='font-size: 8px;'>technology</span> <span style='font-size: 20px;'>tips</span> <span style='font-size: 24px;'>tool</span> <span style='font-size: 28px;'>tools</span> <span style='font-size: 16px;'>toread</span> <span style='font-size: 32px;'>travel</span> <span style='font-size: 16px;'>tutorial</span> <span style='font-size: 20px;'>tutorials</span> <span style='font-size: 36px;'>tv</span> <span style='font-size: 20px;'>twitter</span> <span style='font-size: 8px;'>typography</span> <span style='font-size: 12px;'>ubuntu</span> <span style='font-size: 20px;'>usability</span> <span style='font-size: 8px;'>video</span> <span style='font-size: 20px;'>videos</span> <span style='font-size: 16px;'>visualization</span> <span style='font-size: 20px;'>web</span> <span style='font-size: 24px;'>web2.0</span> <span style='font-size: 12px;'>webdesign</span> <span style='font-size: 20px;'>webdev</span> <span style='font-size: 20px;'>wiki</span> <span style='font-size: 20px;'>windows</span> <span style='font-size: 16px;'>wordpress</span> <span style='font-size: 12px;'>work</span> <span style='font-size: 32px;'>writing</span> <span style='font-size: 20px;'>youtube</span></div>  </body>
    </html>
    EOF
    css = <<-EOF
    /* Generated by Balsamiq Exporter */
* {
  vertical-align: baseline;
  font-weight: inherit;
  font-family: inherit;
  font-style: inherit;
  font-size: 100%;
  border: 0 none;
  outline: 0;
  padding: 0;
  margin: 0;
}

body {
  background-color: #f8f4ed;
  font-family: "Comic Sans MS", Arial,sans-serif;
  color: #010101;
}

div {
  background-color: #ffffff;
  outline: 2px solid #202028;
  text-align: center;
}

a {
  color:#0101ff;
}

a:link {
  color:#0101ff;
}

a:hover {
  color:#FD0101;
}

    EOF
    js = <<-EOF
    /* Generated by Balsamiq Exporter
/* Simon Willison's cool hack to build out multiple onload events */
function addLoadEvent(func) 
{
  var oldonload = window.onload;
  if (typeof window.onload != 'function') 
  {
    window.onload = func;
  } 
  else 
  {
    window.onload = function() 
    {
      if (oldonload) 
      {
        oldonload();
      }
      func();
    }
  }
}

    EOF
    filename = "tagcloud"
    srand 1234
    TestingFileSupport::test_elements(filename, data, html, css, js, false)
  end

end
