#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_LinkBar method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_LinkBar(c)
    # properly add text to @html_header, @html_body @css, @js 
    bold, italic, underline, font, color, align = get_text_properties(c)
    text = CGI::unescape(c[:text])
    links = text.split(",")
    links.collect! {|e| "<span><a href=''>#{modify_text(e, bold, italic, underline)}</a></span>"}
    linkbar = links.join("|")
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}";
        style="position: absolute; font-size:#{font}; text-align: #{align}; left: #{c[:x]}px; top: #{c[:y]}px;
        z-index: #{c[:zOrder]}; outline: none; background-color: transparent; color: #{color};">
        #{linkbar}
    </div>
    EOF
    
    unless @css.match("#{c[:controlTypeID]}")
      @css += <<-EOF
.#{c[:controlTypeID]} span {
  margin: 5px; 
}
EOF
    end
  end  
end
