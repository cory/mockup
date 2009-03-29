#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_List method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_List(c)
    # properly add text to @html_header, @html_body @css, @js 
    bold, italic, underline, font, wrongcolor, align = get_text_properties(c)
    text = CGI::unescape(c[:text])
    header = c[:hasHeader] != "true" ? false : true
    color = c[:color] ? c[:color] : "#FFFFFF"
    headercolor = "#CCCCCC"
    altcolor = c[:alternateRowColor] ? c[:alternateRowColor] : "#FFFFFF"
    rows = text2row(text, header, bold, italic, underline)
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; width:#{c[:w]}px; height:#{c[:h]}px;
        z-index: #{c[:zOrder]}; background-color: transparent;">
        <table cellspacing="0" style="border-collapse: collapse; border-spacing: 0;width:100%;">
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
    EOF
  end  
end
