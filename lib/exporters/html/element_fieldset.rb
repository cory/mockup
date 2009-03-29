#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_FieldSet method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_FieldSet(c)
    # properly add text to @html_header, @html_body @css, @js 
    header = CGI::unescape(c[:text])
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]}px;
          font-size:10pt; background-color: transparent;">
      <div style="position: absolute; left: 10px; top: -14px; padding: 4px">#{header}</div>
    </div>
    EOF
  end  
end
