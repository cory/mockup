#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_TitleWindow method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_TitleWindow(c)
    # properly add text to @html_header, @html_body @css, @js 
    topsize = c[:topheight] ? c[:topheight].to_i - 2 : 24
    bottomsize = c[:bottomheight] ? c[:bottomheight].to_i - 2 : 24
    name = CGI::unescape(c[:text])
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]}px;
          font-size:12pt; ">
      <div style="position: absolute; text-align: left; left: 0px; top: 0px; width:100%; height: #{topsize}px">#{name}</div>
      <div style="position: absolute; text-align: left; left: 0px; top: #{c[:h].to_i-bottomsize}px; width:100%; height: #{topsize}px"></div>
    </div>
    EOF
  end  
end
