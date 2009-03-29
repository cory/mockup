#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Accordion method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_Accordion(c)
    elements = CGI::unescape(c[:text]).split("\n")
    if c[:verticalScrollbar] == "false"
      fill = ""
    else
      fill = %Q!Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sem. Cras aliquam nunc et pede. Aenean euismod. Aenean placerat, ipsum quis cursus semper, tellus turpis facilisis nisi, non varius nunc sem eu ipsum. Quisque imperdiet dignissim sapien. Sed iaculis. Proin ullamcorper tortor eu neque. Quisque sed mauris mattis ante lacinia volutpat. Quisque id arcu. Fusce sit amet orci. Phasellus volutpat purus a erat. Ut condimentum!
    end
      
    accordion = ""
    elements.each do |el|
      accordion += <<-EOF
      <div><a href="" id="#{el}">#{el}</a><div class="content"><p>#{fill}</p></div></div>
    EOF
    end
        
    style = "position: absolute; left: #{c[:x]}px; top: #{c[:y]}px;  z-index: #{c[:zOrder]}; font-size:10pt; width: #{c[:w]}px; height: #{c[:h]}px; outline: none; outline-top: 2px solid #202028;  background-color:transparent;"
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
          style="#{style}">
      #{accordion}
    </div>
    EOF
    
    @css += <<-EOF

##{c[:controlTypeID]}#{c[:controlID]} div {
  text-align: left;
  height: #{100/elements.length}%;
  overflow: hidden;
}

##{c[:controlTypeID]}#{c[:controlID]} .content {
  height: 0px;
  overflow: hidden;
  outline: none;
}

##{c[:controlTypeID]}#{c[:controlID]}:hover .content {
  height: 0px;
  overflow: hidden;
  outline: none;
}

##{c[:controlTypeID]}#{c[:controlID]}:hover > div {
  height: 10%;
  overflow: hidden;
}

##{c[:controlTypeID]}#{c[:controlID]}:hover div:hover .content {
  height: 100%;
  overflow: auto;
  background-color: none;
}

##{c[:controlTypeID]}#{c[:controlID]}:hover div:hover p {
  margin: 5px;
}

##{c[:controlTypeID]}#{c[:controlID]}:hover > div:hover {
  text-align: left;
  height: #{elements.length*(100/elements.length) - 10*(elements.length-1)}%;
  background-color: #AAEEBB;
  overflow: hidden;
}

##{c[:controlTypeID]}#{c[:controlID]} a {
  padding-left:10px;
  padding-top:5px;
  padding-bottom:5px;
  display: block;
  color: #010101;
  text-decoration: none;
}

##{c[:controlTypeID]}#{c[:controlID]}:hover a {
  padding-top:2px;
  padding-bottom:2px;
}

##{c[:controlTypeID]}#{c[:controlID]} a:hover {
  color: #010101;
}
    EOF
  end  
end
