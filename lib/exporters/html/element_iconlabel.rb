#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_IconLabel method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_IconLabel(c)
    # properly add text to @html_header, @html_body @css, @js 
    color = c[:color] ? c[:color] : "rgba(1,1,1,1.0)"
    below = c[:labelPosition] == "right" ? false : true
    text = CGI::unescape(c[:text])
    # fix up widths
    c[:w] = 48
    c[:h] = 48
    if below
      @html_body += <<-EOF
      <div class="#{c[:controlIDType]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
          style="position: absolute; font-size:10pt; left: #{c[:x]}px; top: #{c[:y]}px; 
          width: #{c[:w]}px; height: z-index: #{c[:zOrder]}; outline: none; background-color: transparent">
        <div
            style="position: absolute; font-size:10pt; outline: 2px solid #{color};
            width: 100%; height: #{c[:h]}px; z-index: #{c[:zOrder]}">
        </div>
        <div
            style="position: absolute; font-size:10pt; left: 0px; top: #{c[:h]}px; text-align: center;
            width: 100%; z-index: #{c[:zOrder]}; outline: none; background-color: transparent">
            #{text}
        </div>
      </div>
      EOF
    else
      @html_body += <<-EOF
      <div class="#{c[:controlIDType]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
          style="position: absolute; font-size:10pt; left: #{c[:x]}px; top: #{c[:y]}px; 
          height: #{c[:h]}px; z-index: #{c[:zOrder]}; outline: none; background-color: transparent">
        <div
            style="float:left; font-size:10pt; outline: 2px solid #{color};
            width: #{c[:w]}px; height: 100%; z-index: #{c[:zOrder]}">
        </div>
        <div
            style="float:left; font-size:10pt; line-height: #{c[:h]}px; margin-left: 5px;
            z-index: #{c[:zOrder]}; outline: none; background-color: transparent; color: #{color};">
            #{text}
        </div>
      </div>
      EOF
    end
  end  
end
