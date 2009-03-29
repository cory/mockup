#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_HSplitter method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_HSplitter(c)
    # properly add text to @html_header, @html_body @css, @js 
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}"
      style="position: absolute; font-size:10pt; text-align: left; left: #{c[:x]}px; top: #{c[:y]}px; 
      width: 2px; height: #{c[:h]}px; z-index: #{c[:zOrder]}; outline: none; background-color: #010101">
    </div>
    <div class="#{c[:controlTypeID]}"
      style="position: absolute; font-size:10pt; text-align: left; left: #{c[:x]+10}px; top: #{c[:y]}px; 
      width: 2px; height: #{c[:h]}px; z-index: #{c[:zOrder]}; outline: none; background-color: #010101">
    </div>
    EOF
  end  
end
