#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Canvas method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_Canvas(c)
    # properly add text to @html_header, @html_body @css, @js 
    color = c[:color] ? c[:color] : "RGBA(255,255,255,1.0)"
    alpha = c[:backgroundAlpha] ? c[:backgroundAlpha] : "1.0"
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]}px;
        z-index: #{c[:zOrder]}; background-color: transparent;">
      <div class="#{c[:controlTypeID]}"
          style="position: absolute; left:0px; top:0px; width: #{c[:w]}px; height: #{c[:h]}px;
            z-index: #{c[:zOrder]}; outline: none; background-color: #{color}; opacity: #{alpha}";>
      </div>
    </div>
    EOF
  end  
end
