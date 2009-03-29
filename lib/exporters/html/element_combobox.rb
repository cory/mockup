#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_ComboBox method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_ComboBox(c)
    # properly add text to @html_header, @html_body @css, @js 
    combotext = CGI::unescape(c[:text])
    labels = combotext.split("\n")
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; z-index: #{c[:zOrder]};
          font-size:10pt; outline:none; background-color: transparent;">
      <div class="balsamiq_combo" style="text-align: left; z-index: #{c[:zOrder]+1}">
        #{labels[0]}
    EOF
    fields = labels[1..-1]
    fields.each do |field|
      @html_body += <<-EOF
        <div class="balsamiq_combo_element" style="text-align: left; outline: none; z-index: #{c[:zOrder]+2}">
          #{field}
        </div>
      EOF
    end
    @html_body += <<-EOF
      </div>
    </div>
    EOF
    unless @css.match("balsamiq_combo")
      @css += <<-EOF
.balsamiq_combo {
  background-color: #CCCCCC;
}

.balsamiq_combo:hover {
  background-color: #AAEEBB;
}

.balsamiq_combo:hover .balsamiq_combo_element{
  display:block;
}

.balsamiq_combo_element {
  display:none;
}

.balsamiq_combo_element:hover {
  background-color: #CCCCCC;
}
    EOF
    end  
  end  
end
