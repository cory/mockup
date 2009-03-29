#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_HelpButton method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_HelpButton(c)
    # properly add text to @html_header, @html_body @css, @js 
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y].to_i-2}px; width: #{c[:w]}px; height: #{c[:h]}px;
          font-size:16pt; outline: none; background-color:transparent;">
          O
    </div>
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y].to_i + 4}px; width: #{c[:w]}px; height: #{c[:h]}px;
          font-size:9pt; outline: none; background-color:transparent;">
          ?
    </div>
    EOF
  end  
end
