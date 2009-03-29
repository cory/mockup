#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_DataGrid method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_DataGrid(c)
    # properly add text to @html_header, @html_body @css, @js 
    bold, italic, underline, font, wrongcolor, align = get_text_properties(c)
    text = CGI::unescape(c[:text])
    header = c[:hasHeader] != "false" ? true : false
    color = c[:color] ? c[:color] : "RGBA(237,243,238,1.0)"
    headercolor = "#CCCCCC"
    altcolor = c[:alternateRowColor] ? c[:alternateRowColor] : "#FFFFFF"
    border = c[:borderStyle] != "none" ? "border: 1px solid #010101" : ""
    cellborder = c[:vLines] != "false" ? "border-left: 1px solid #010101;" : ""
    cellborder += c[:hLines] != "true" ? "" : "border-bottom: 1px solid #010101;"
    rows = text2row(text, header, bold, italic, underline)
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; width:#{c[:w]}px; height:#{c[:h]}px;
        z-index: #{c[:zOrder]}; outline: none; background-color: transparent;">
        <table cellspacing="0" style="border-collapse: collapse; border-spacing: 0;width:100%; height:100%; #{border};">
        #{rows}
        </table>
    </div>
    EOF
    
    @css += <<-EOF
##{c[:controlTypeID]}#{c[:controlID]} {
  font-size:#{font}; 
  text-align: #{align}; 
}

##{c[:controlTypeID]}#{c[:controlID]} .header {
  background-color: #{headercolor};
}


##{c[:controlTypeID]}#{c[:controlID]} .row0 {
  background-color: #{color};
}

##{c[:controlTypeID]}#{c[:controlID]} .row1 {
  background-color: #{altcolor};
}

##{c[:controlTypeID]}#{c[:controlID]} td {
  #{cellborder}
}

##{c[:controlTypeID]}#{c[:controlID]} th {
  #{cellborder}
}
    EOF
  end  
end
