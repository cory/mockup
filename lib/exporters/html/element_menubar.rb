#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_MenuBar method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_MenuBar(c)
    # properly add text to @html_header, @html_body @css, @js 
    text = CGI::unescape(c[:text])
    links = text.split(",")
    links.collect! {|e| "<span>#{e}</span>"}
    linkbar = links.join("")
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}";
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; height: #{c[:h]-4}px;
        z-index: #{c[:zOrder]};">
        #{linkbar}
    </div>
    EOF

    unless @css.match("#{c[:controlTypeID]}")
      @css += <<-EOF
.#{c[:controlTypeID]} span {
  margin: 12px; 
  font-size: 14px;
}
EOF
    end
  end  
end
