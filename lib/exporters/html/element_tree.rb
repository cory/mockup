#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Tree method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_Tree(c)
    # properly add text to @html_header, @html_body @css, @js 
    text = CGI::unescape(c[:text])
    tree = ""
    rows = text.split("\n")
    rows.each do |line|
      first = line.index(/[^\.\>\ \s]/)
      tree += "<p>"
      if first > 0
        tree += line[0..first-1].gsub!(/[\.\>\ ]/, "&nbsp;&nbsp;")
      end
      tree += line[first..-1] + "</p>\n"
    end
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; text-align: left; left: #{c[:x]}px; top: #{c[:y]}px; width:#{c[:w]}px;
        z-index: #{c[:zOrder]};">
        #{tree}
    </div>
    EOF
  end  
end
