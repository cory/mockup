#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Map method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_Map(c)
    # properly add text to @html_header, @html_body @css, @js 
    unless @html_header.match("maps.google.com")
      @html_header += <<-EOF
      </script>
      <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=ABQIAAAAzr2EBOXUKnm_jVnk0OJI7xSosDVG8KKPE1-m51RBrvYughuyMxQ-i1QfUnH94QxWIa6N4U6MouMmBA";type="text/javascript"></script>
      <script type="text/javascript">

      EOF
    end
    @html_header += <<-EOF
      addLoadEvent(function() {initialize_gmap("#{c[:controlTypeID]}#{c[:controlID]}")});
    EOF
    
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]}px;">
    </div>
    EOF
    unless @js.match("initialize_gmap")
      @js += <<-EOF

function initialize_gmap(id)
{
  if (GBrowserIsCompatible()) 
  {
    var map = new GMap2(document.getElementById(id));
    map.setCenter(new GLatLng(37.4419, -122.1419), 13);
  }
}
    EOF
    end
    unless @css.match("canvas")
      @css += <<-EOF

.#{c[:controlTypeID]} * {
	background-color: transparent;
	outline: none
}

      EOF
    end
  end
end
