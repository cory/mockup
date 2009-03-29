#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Comment method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_StickyNote(c)
    # properly add text to @html_header, @html_body @css, @js 
    comment = CGI::unescape(c[:text])
    color = c[:color] ? c[:color] : "rgba(252,251,94,1.0)"
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]}px; z-index: #{c[:zOrder]};
          font-size:10pt; background-color: #{color};">
      #{comment}
    </div>
    EOF
  end  
end
