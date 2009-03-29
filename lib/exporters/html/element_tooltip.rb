#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Tooltip method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_Tooltip(c)
    # properly add text to @html_header, @html_body @css, @js 
    text = CGI::unescape(c[:text])
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; height: #{c[:h]-4}px;
        z-index: #{c[:zOrder]}; font-size: 10pt; padding-left: 4px; padding-right: 4px; padding-top: 6px">
      #{text}
    </div>
    EOF
  end  
end
