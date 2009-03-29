#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_VSplitter method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_VSplitter(c)
    # properly add text to @html_header, @html_body @css, @js 
    @html_body += <<-EOF
      <div class="#{c[:controlTypeID]}"
        style="position: absolute; font-size:10pt; text-align: left; left: #{c[:x]}px; top: #{c[:y]}px; 
        width: #{c[:w]}px; height: 2px; z-index: #{c[:zOrder]}; outline: none; background-color: #010101">
      </div>
      <div class="#{c[:controlTypeID]}"
        style="position: absolute; font-size:10pt; text-align: left; left: #{c[:x]}px; top: #{c[:y]+10}px; 
        width: #{c[:w]}px; height: 2px; z-index: #{c[:zOrder]}; outline: none; background-color: #010101">
      </div>
    EOF
  end  
end
