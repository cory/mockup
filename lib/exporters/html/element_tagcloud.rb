#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_TagCloud method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_TagCloud(c)
    # properly add text to @html_header, @html_body @css, @js 
    tagtext = CGI::unescape(c[:text])
    tags = tagtext.split(" ")
    tags.collect! {|e| "<span style='font-size: #{rand(8)*4 + 8}px;'>#{e}</span>"}
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; height: #{c[:h]}px; width: #{c[:w]}px; z-index: 
          #{c[:zOrder]}; overflow: hidden; outline: none; background-color: transparent">
    EOF
    @html_body += tags.join(" ")
    @html_body += "</div>"
  end  
end
