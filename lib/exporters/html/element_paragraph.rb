#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Paragraph method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_Paragraph(c)
    # properly add text to @html_header, @html_body @css, @js 
    bold, italic, underline, font, color, align = get_text_properties(c)
    text = CGI::unescape(c[:text])
    textlines = text.split("\n")
    text = textlines.collect!{|e| "<p class='text'>#{modify_text(e, bold, italic, underline)}</p>"}.join("\n")
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}";
        style="position: absolute; font-size:#{font}; text-align: #{align}; left: #{c[:x]}px; top: #{c[:y]}px;
        z-index: #{c[:zOrder]}; outline: none; background-color: transparent; color: #{color};">
        #{text}
    </div>
    EOF
  end  
end
