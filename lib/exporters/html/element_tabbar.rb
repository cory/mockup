#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_TabBar method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_TabBar(c)
    # properly add text to @html_header, @html_body @css, @js 
    labeltext = CGI::unescape(c[:text])
    labels = labeltext.split(", ")
    ypos = c[:tabVPosition] != "bottom" ? -22 : c[:h]+5
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; height: #{c[:h]}px; width: #{c[:w]}px; z-index: #{c[:zOrder]};">
      <div style="position: absolute; left: 0px; top: #{ypos}px; height: 20px; width: #{c[:w]}px; z-index: #{c[:zOrder]};
                  outline: none; background-color: transparent;">
    EOF
    make_buttons(c[:controlTypeID], "#{c[:controlID]}tab", labels, 0, 0, 20, 0, c[:zOrder], false)
    @html_body += "</div></div>"
  end  
end
