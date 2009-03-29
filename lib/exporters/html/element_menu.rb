#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Menu method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_Menu(c)
    # properly add text to @html_header, @html_body @css, @js 
    text = CGI::unescape(c[:text])
    table = ""
    rows = text.split("\n")
    rows.each do |line|
      textarray = []
      if line[0..0] == "o"
        textarray[0] = "o"
        line = line[2..-1]
      elsif line[0..0] == "x"
        textarray[0] = "x"
        line = line[2..-1]
      elsif line[0..0] == "-"
        table += "<tr><td colspan='3'>---------------------</td></tr>\n"
        next
      elsif line[0..0] == "="
        table += "<tr><td colspan='3'>---------------------</td></tr>\n"
        next
      else
        textarray[0] = ""
      end

      if line.match(",")
        temp = line.split(",")
        textarray[1] = temp[0]
        textarray[2] = temp[1]
      else
        if line[-1..-1] == ">"
          textarray[1] = line[0..-2]
          textarray[2] = ">"
        else
          textarray[1] = line
          textarray[2] = ""
        end
      end
      table += "<tr><td class='left'>#{textarray[0]}</td><td class='middle'>#{textarray[1]}</td><td class='right'>#{textarray[2]}</td></tr>\n"
    end
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; width:#{c[:w]}px;
        z-index: #{c[:zOrder]}; background-color: transparent; ">
        <table cellspacing="0" style="border-collapse: collapse; border-spacing: 0; width:100%; height:100%">
        #{table}
        </table>
    </div>
    EOF
    @css += <<-EOF
.{c[:controlTypeID]} .left {
  font-size: 9pt;
  text-align: left;
  width: 10px;
}

.{c[:controlTypeID]} .middle {
  font-size: 9pt;
  text-align: left;
  width: 55%;
}

.{c[:controlTypeID]} .right {
  font-size: 9pt;
  text-align: right;
}
    EOF
  end  
end
