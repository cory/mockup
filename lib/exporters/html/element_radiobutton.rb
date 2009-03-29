#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_RadioButton method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_RadioButton(c)
    # properly add text to @html_header, @html_body @css, @js 
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; z-index: #{c[:zIndex]};
          font-size:10pt; color: #010101; outline: none; background-color: transparent;">
      <input type="radio" name="balsamiq" id="#{c[:controlTypeID]}#{c[:controlID]}radio">
      <label for="#{c[:controlTypeID]}#{c[:controlID]}checkbox">#{c[:text] ? CGI::unescape(c[:text]) : ""}</label>
    </div>
    EOF
  end  
end
