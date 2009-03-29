#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_SearchBox method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_SearchBox(c)
    # properly add text to @html_header, @html_body @css, @js 
    text = CGI::unescape(c[:text])
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; display: table; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]-2}px;
        z-index: #{c[:zOrder]}; outline: none;border: 1px solid #010101; ">
        <input style="background-color: transparent" name=search type="text" onKeyPress="" value="#{text}"></input>
    </div>
    EOF
    
    @css += <<-EOF
.#{c[:controlTypeID]} {
  -moz-border-radius: 10px;
  -webkit-border-radius:10px;
  border-radius: 10px;
}

.#{c[:controlTypeID]} input {
  font-size: 11pt;
  text-align: left;
  margin-left: 8px;
  margin-right: 32px;
}
    EOF
  end  
end
