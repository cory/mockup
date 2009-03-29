#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

require "#{File.dirname(__FILE__)}/../testing_file_support"

describe BalsamiqControlParser do
  it "properly handles buttonbar" do
    data = <<-EOF
        <mockup version="1.0" skin="sketch">
  <controls>
    <control controlID="0" controlTypeID="com.balsamiq.mockups::ButtonBar" x="18" y="12" w="-1" h="-1" zOrder="0" locked="false" isInGroup="-1">
      <controlProperties>
        <text>One%2C%20Two%2C%20Three</text>
      </controlProperties>
    </control>
    <control controlID="1" controlTypeID="com.balsamiq.mockups::ButtonBar" x="18" y="54" w="-1" h="-1" zOrder="1" locked="false" isInGroup="-1">
      <controlProperties>
        <text>short%2C%20long%20button%2C%20verrrrry%20long%20button%2C%20tiny</text>
      </controlProperties>
    </control>
    <control controlID="2" controlTypeID="com.balsamiq.mockups::ButtonBar" x="18" y="100" w="-1" h="-1" zOrder="2" locked="false" isInGroup="-1">
      <controlProperties>
        <text>short%2C%20long%20button%2C%20verrrrry%20long%20button%2C%20tiny</text>
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
      <link rel="stylesheet" type="text/css" href="buttonbar.css" />
    <title>Balsamiq</title>
    <script type="text/javascript">
    </script>
  </head>

  <body>
    <div class="ButtonBar" id="ButtonBar0"
          style="position: absolute; left: 18px; top: 12px; height: 22px; z-index: 0;
          font-size:10pt; outline: none; background-color: transparent;">
      <div class="ButtonBar" id="ButtonBar0_0"
          style="float: left; height: 22px; outline: none; padding-right:3px; background-color: transparent;">
        <div class="balsamiq_shadow"
          style="position: relative; top: 3px; left: 3px; z-index: 0;
                 font-size:10pt; height: 19px; outline: 2px solid #010101; background-color:#010101;">
          <p style="padding-left:10px;padding-right:10px;">One</p>
        </div>
        <div class="balsamiq_button"
          style = "position: relative; z-index: 1;
             font-size:10pt; top: -22px; height: 19px;">
          <a href=""><p style="padding-left:10px;padding-right:10px;">One</p></a>
        </div>
      </div>
      <div class="ButtonBar" id="ButtonBar0_1"
          style="float: left; height: 22px; outline: none; padding-right:3px; background-color: transparent;">
        <div class="balsamiq_shadow"
          style="position: relative; top: 3px; left: 3px; z-index: 0;
                 font-size:10pt; height: 19px; outline: 2px solid #010101; background-color:#010101;">
          <p style="padding-left:10px;padding-right:10px;">Two</p>
        </div>
        <div class="balsamiq_button"
          style = "position: relative; z-index: 1;
             font-size:10pt; top: -22px; height: 19px;">
          <a href=""><p style="padding-left:10px;padding-right:10px;">Two</p></a>
        </div>
      </div>
      <div class="ButtonBar" id="ButtonBar0_2"
          style="float: left; height: 22px; outline: none; padding-right:3px; background-color: transparent;">
        <div class="balsamiq_shadow"
          style="position: relative; top: 3px; left: 3px; z-index: 0;
                 font-size:10pt; height: 19px; outline: 2px solid #010101; background-color:#010101;">
          <p style="padding-left:10px;padding-right:10px;">Three</p>
        </div>
        <div class="balsamiq_button"
          style = "position: relative; z-index: 1;
             font-size:10pt; top: -22px; height: 19px;">
          <a href=""><p style="padding-left:10px;padding-right:10px;">Three</p></a>
        </div>
      </div>
    </div>
    <div class="ButtonBar" id="ButtonBar1"
          style="position: absolute; left: 18px; top: 54px; height: 22px; z-index: 1;
          font-size:10pt; outline: none; background-color: transparent;">
      <div class="ButtonBar" id="ButtonBar1_0"
          style="float: left; height: 22px; outline: none; padding-right:3px; background-color: transparent;">
        <div class="balsamiq_shadow"
          style="position: relative; top: 3px; left: 3px; z-index: 1;
                 font-size:10pt; height: 19px; outline: 2px solid #010101; background-color:#010101;">
          <p style="padding-left:10px;padding-right:10px;">short</p>
        </div>
        <div class="balsamiq_button"
          style = "position: relative; z-index: 2;
             font-size:10pt; top: -22px; height: 19px;">
          <a href=""><p style="padding-left:10px;padding-right:10px;">short</p></a>
        </div>
      </div>
      <div class="ButtonBar" id="ButtonBar1_1"
          style="float: left; height: 22px; outline: none; padding-right:3px; background-color: transparent;">
        <div class="balsamiq_shadow"
          style="position: relative; top: 3px; left: 3px; z-index: 1;
                 font-size:10pt; height: 19px; outline: 2px solid #010101; background-color:#010101;">
          <p style="padding-left:10px;padding-right:10px;">long button</p>
        </div>
        <div class="balsamiq_button"
          style = "position: relative; z-index: 2;
             font-size:10pt; top: -22px; height: 19px;">
          <a href=""><p style="padding-left:10px;padding-right:10px;">long button</p></a>
        </div>
      </div>
      <div class="ButtonBar" id="ButtonBar1_2"
          style="float: left; height: 22px; outline: none; padding-right:3px; background-color: transparent;">
        <div class="balsamiq_shadow"
          style="position: relative; top: 3px; left: 3px; z-index: 1;
                 font-size:10pt; height: 19px; outline: 2px solid #010101; background-color:#010101;">
          <p style="padding-left:10px;padding-right:10px;">verrrrry long button</p>
        </div>
        <div class="balsamiq_button"
          style = "position: relative; z-index: 2;
             font-size:10pt; top: -22px; height: 19px;">
          <a href=""><p style="padding-left:10px;padding-right:10px;">verrrrry long button</p></a>
        </div>
      </div>
      <div class="ButtonBar" id="ButtonBar1_3"
          style="float: left; height: 22px; outline: none; padding-right:3px; background-color: transparent;">
        <div class="balsamiq_shadow"
          style="position: relative; top: 3px; left: 3px; z-index: 1;
                 font-size:10pt; height: 19px; outline: 2px solid #010101; background-color:#010101;">
          <p style="padding-left:10px;padding-right:10px;">tiny</p>
        </div>
        <div class="balsamiq_button"
          style = "position: relative; z-index: 2;
             font-size:10pt; top: -22px; height: 19px;">
          <a href=""><p style="padding-left:10px;padding-right:10px;">tiny</p></a>
        </div>
      </div>
    </div>
    <div class="ButtonBar" id="ButtonBar2"
          style="position: absolute; left: 18px; top: 100px; height: 22px; z-index: 2;
          font-size:10pt; outline: none; background-color: transparent;">
      <div class="ButtonBar" id="ButtonBar2_0"
          style="float: left; height: 22px; outline: none; padding-right:3px; background-color: transparent;">
        <div class="balsamiq_shadow"
          style="position: relative; top: 3px; left: 3px; z-index: 2;
                 font-size:10pt; height: 19px; outline: 2px solid #010101; background-color:#010101;">
          <p style="padding-left:10px;padding-right:10px;">short</p>
        </div>
        <div class="balsamiq_button"
          style = "position: relative; z-index: 3;
             font-size:10pt; top: -22px; height: 19px;">
          <a href=""><p style="padding-left:10px;padding-right:10px;">short</p></a>
        </div>
      </div>
      <div class="ButtonBar" id="ButtonBar2_1"
          style="float: left; height: 22px; outline: none; padding-right:3px; background-color: transparent;">
        <div class="balsamiq_shadow"
          style="position: relative; top: 3px; left: 3px; z-index: 2;
                 font-size:10pt; height: 19px; outline: 2px solid #010101; background-color:#010101;">
          <p style="padding-left:10px;padding-right:10px;">long button</p>
        </div>
        <div class="balsamiq_button"
          style = "position: relative; z-index: 3;
             font-size:10pt; top: -22px; height: 19px;">
          <a href=""><p style="padding-left:10px;padding-right:10px;">long button</p></a>
        </div>
      </div>
      <div class="ButtonBar" id="ButtonBar2_2"
          style="float: left; height: 22px; outline: none; padding-right:3px; background-color: transparent;">
        <div class="balsamiq_shadow"
          style="position: relative; top: 3px; left: 3px; z-index: 2;
                 font-size:10pt; height: 19px; outline: 2px solid #010101; background-color:#010101;">
          <p style="padding-left:10px;padding-right:10px;">verrrrry long button</p>
        </div>
        <div class="balsamiq_button"
          style = "position: relative; z-index: 3;
             font-size:10pt; top: -22px; height: 19px;">
          <a href=""><p style="padding-left:10px;padding-right:10px;">verrrrry long button</p></a>
        </div>
      </div>
      <div class="ButtonBar" id="ButtonBar2_3"
          style="float: left; height: 22px; outline: none; padding-right:3px; background-color: transparent;">
        <div class="balsamiq_shadow"
          style="position: relative; top: 3px; left: 3px; z-index: 2;
                 font-size:10pt; height: 19px; outline: 2px solid #010101; background-color:#010101;">
          <p style="padding-left:10px;padding-right:10px;">tiny</p>
        </div>
        <div class="balsamiq_button"
          style = "position: relative; z-index: 3;
             font-size:10pt; top: -22px; height: 19px;">
          <a href=""><p style="padding-left:10px;padding-right:10px;">tiny</p></a>
        </div>
      </div>
    </div>
  </body>
</html>

    EOF
    css = <<-EOF
    .balsamiq_button a, a:hover, a:active {
  text-decoration: none;
  color: #010101;
}

.balsamiq_button:hover {
  background-color: #CCCCCC;
}

.balsamiq_button:active {
  background-color: #AAEEBB;
  margin-top: 2px;
}

    EOF
    js = <<-EOF

    EOF
    filename = "buttonbar"
    TestingFileSupport::test_elements(filename, data, html, css, js, false)
  end

end