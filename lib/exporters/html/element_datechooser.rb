#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_DateChooser method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_DateChooser(c)
    # properly add text to @html_header, @html_body @css, @js 
    text = CGI::unescape(c[:text])
    text.gsub!(" ", "&nbsp")
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]-4}px; z-index: #{c[:zIndex]};
          font-size:10pt; background-color: transparent; outline: none">
      <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
            style="padding-left: 4px; text-align: left; float: left; top: #{c[:y]}; width: #{c[:w] - c[:h] - 10}px; height: #{c[:h] - 4}px; z-index: #{c[:zIndex]};">
        #{text}
      </div>
      <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
            style="float: right; top: #{c[:y]}; width: #{c[:h]-2}px; height: #{c[:h] - 4}px; z-index: #{c[:zIndex]};">
      </div>
    </div>
    EOF
  end  
end
