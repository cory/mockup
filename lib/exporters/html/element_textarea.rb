#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_TextArea method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_TextArea(c)
    # properly add text to @html_header, @html_body @css, @js 
    text = CGI::unescape(c[:text])
    textlines = text.split("\n")
    color = c[:color] ? c[:color] : "RGBA(255,255,255,1.0)"
    alpha = c[:backgroundAlpha] ? c[:backgroundAlpha] : "1.0"
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]}px;
        z-index: #{c[:zOrder]}; outline: none; background-color: transparent;">
      <div class="#{c[:controlTypeID]}"
          style="position: absolute; left:1px; top:1px; width: #{c[:w]+2}px; height: #{c[:h]+2}px;
            z-index: #{c[:zOrder]}; outline: none; background-color: #{color}; opacity: #{alpha}";>
      </div>
      <div class="#{c[:controlTypeID]}"
          style="position: absolute; left: 0px; top: 0px; width: #{c[:w]}px; height: #{c[:h]}px;
            z-index: #{c[:zOrder]}; border: 2px solid #010101; outline: none; background-color: transparent";>
      </div>
      <div style="position: absolute; font-size: 13px; text-align: left; margin: 4px;
        z-index: #{c[:zOrder]+1}; outline: none; background-color: transparent;">
        #{textlines.collect!{|e| "<p>#{e}</p>"}.join("\n")}
      </div>
    </div>
    EOF
  end  
end
