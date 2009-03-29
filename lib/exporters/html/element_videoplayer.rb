#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_VideoPlayer method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_VideoPlayer(c)
    # properly add text to @html_header, @html_body @css, @js 
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; font-size:10pt; text-align: left; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]}px; z-index: #{c[:zOrder]}">
      <object width="#{c[:w]}" height="#{c[:h]}">
        <param name="movie" value="http://www.youtube.com/v/y-LhyAVzDBI&hl=en&fs=1"></param>
        <param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param>
        <embed src="http://www.youtube.com/v/y-LhyAVzDBI&hl=en&fs=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="#{c[:w]}" height="#{c[:h]}"></embed>
      </object>
    </div>
    EOF
  end  
end
