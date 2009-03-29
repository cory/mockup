#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_RoundButton method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_RoundButton(c)
    # properly add text to @html_header, @html_body @css, @js 
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y]-18}px;
          font-size:36pt; outline: none; background-color:transparent;">
          O
    </div>
    EOF
  end  
end
