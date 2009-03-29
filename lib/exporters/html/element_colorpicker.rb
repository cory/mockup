#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_ColorPicker method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_ColorPicker(c)
    # properly add text to @html_header, @html_body @css, @js 
    color = c[:color] ? c[:color] : "#0101ff"
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]}px; z-index: #{c[:zIndex]};
          font-size:10pt; color: #010101; background-color: #{color};">
      <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
            style="position: relative; left: #{c[:w]*0.4}px; top: #{c[:h]*0.7}px; z-index: #{c[:zIndex]};
            font-size:10pt; color: #010101; background-color: transparent; outline: none;">
            \\\/
      </div>
    </div>
    EOF
  end  
end
