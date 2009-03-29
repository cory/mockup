#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Title method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_Title(c)
    # properly add text to @html_header, @html_body @css, @js 
    text = CGI::unescape(c[:text])
    textlines = text.split("\n")
    color = c[:color] ? c[:color] : "RGBA(1,1,1,1.0)"
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; height: #{c[:h]}px;
        z-index: #{c[:zOrder]}; color: #{color}; outline: none; background-color: transparent; font-size: 32pt;">
        #{text}
    </div>
    EOF
  end  
end
