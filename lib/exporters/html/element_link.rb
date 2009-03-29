#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Link method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_Link(c)
    # properly add text to @html_header, @html_body @css, @js 
    bold, italic, underline, font, color, align = get_text_properties(c)
    text = modify_text(CGI::unescape(c[:text]), bold, italic, underline)
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}";
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; font-size: #{font}; text-align: #{align};
        z-index: #{c[:zOrder]}; outline: none; background-color: transparent; color: #{color};">
        <a href="">#{text}</a>
    </div>
    EOF
  end  
end
