#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_HRule method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_HRule(c)
    # properly add text to @html_header, @html_body @css, @js 
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: 2px;
          font-size:10pt; outline: none; background-color: #010101;">
    </div>
    EOF
  end  
end
