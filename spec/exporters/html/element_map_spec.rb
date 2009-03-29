#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

require "#{File.dirname(__FILE__)}/../testing_file_support"

describe BalsamiqControlParser do
  it "properly handles map" do
    data = <<-EOF
            <mockup version="1.0" skin="sketch">
      <controls>
        <control controlID="32" controlTypeID="com.balsamiq.mockups::Map" x="49" y="21" w="-1" h="-1" zOrder="0" locked="false" isInGroup="-1"/>
        <control controlID="33" controlTypeID="com.balsamiq.mockups::Map" x="345" y="22" w="473" h="271" zOrder="1" locked="false" isInGroup="-1"/>
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
      <link rel="stylesheet" type="text/css" href="map.css" />
      <script type = "text/javascript" src="basic.js"> </script>
      <script type = "text/javascript" src="map.js"> </script>
    <title>Balsamiq</title>
    <script type="text/javascript">
      </script>
      <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=ABQIAAAAzr2EBOXUKnm_jVnk0OJI7xSosDVG8KKPE1-m51RBrvYughuyMxQ-i1QfUnH94QxWIa6N4U6MouMmBA";type="text/javascript"></script>
      <script type="text/javascript">

      addLoadEvent(function() {initialize_gmap("Map32")});
      addLoadEvent(function() {initialize_gmap("Map33")});
    </script>
  </head>

  <body>
    <div class="Map" id="Map32"
        style="position: absolute; left: 49px; top: 21px; width: 252px; height: 222px;">
    </div>
    <div class="Map" id="Map33"
        style="position: absolute; left: 345px; top: 22px; width: 473px; height: 271px;">
    </div>
  </body>
</html>

    EOF
    css = <<-EOF

.Map * {
	background-color: transparent;
	outline: none
}


.Map * {
	background-color: transparent;
	outline: none
}


    EOF
    js = <<-EOF

function initialize_gmap(id)
{
  if (GBrowserIsCompatible()) 
  {
    var map = new GMap2(document.getElementById(id));
    map.setCenter(new GLatLng(37.4419, -122.1419), 13);
  }
}

    EOF
    filename = "map"
    TestingFileSupport::test_elements(filename, data, html, css, js, false)
  end

end