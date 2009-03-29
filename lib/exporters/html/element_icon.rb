#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Icon method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_Icon(c)
    # properly add text to @html_header, @html_body @css, @js 
    color = c[:color] ? c[:color] : "rgba(1,1,1,1.0)"
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; font-size:10pt; outline: 2px solid #{color}; text-align: left; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]}px; z-index: #{c[:zOrder]}">
    </div>
    EOF
  end  
end
