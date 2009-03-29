#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_VerticalTabBar method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_VerticalTabBar(c)
    # properly add text to @html_header, @html_body @css, @js 
    labeltext = CGI::unescape(c[:text])
    labels = labeltext.split("\n")
    divxpos = c[:position] != "right" ? 105 + c[:x] : c[:x]
    tabxpos = c[:position] != "right" ? -105 : c[:w] - 102
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
          style="position: absolute; left: #{divxpos}px; top: #{c[:y]}px; height: #{c[:h]}px; width: #{c[:w]-105}px; z-index: #{c[:zOrder]};">
      <div style="position: absolute; left: #{tabxpos}px; top: 0px; height: 100%; width: 100px; z-index: #{c[:zOrder]};
                  outline: none; background-color: transparent;">
    EOF
    make_buttons(c[:controlTypeID], "#{c[:controlID]}tab", labels, 0, 25, 20, 100, c[:zOrder], true)
    @html_body += "</div></div>"
  end  
end
