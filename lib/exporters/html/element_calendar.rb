#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Calendar method into BalsamiqExportHTML

class BalsamiqExportHTML
  def get_calendar_today
    cal = `cal 01 09`
    cal.split("\n")
  end
  
  def export_Calendar(c)
    calendar = get_calendar_today
    ret = calendar[0].split(" ")
    month = ret[0]
    year = ret[1]
    month = month[0..2].upcase
    calendar = calendar[2..-1]
    height = 16
    rowh = 14
    # properly add text to @html_header, @html_body @css, @js 
    
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; 
        width: #{c[:w]}px; height: #{c[:h]}px; z-index: #{c[:zOrder]};" >
      <div class="balsamiq-calendar-caption" style="font-size:8pt; position:relative; width:100%; height: #{height}%; outline-bottom: 2px solid #010101">
        <a href="#" title="next month" class="nav">&laquo;</a> <strong>#{month} #{year}</strong> <a href="#" title="next month" class="nav">&raquo;</a>
      </div>
      <div class="balsamiq-calendar-headerdiv" style="font-size:8pt; width:100%; height: #{rowh}%; outline: none">
        <div class="balsamiq-calendar-spacer"></div>
        <div class="balsamiq-calendar-header">S</div>
        <div class="balsamiq-calendar-header">M</div>
        <div class="balsamiq-calendar-header">T</div>
        <div class="balsamiq-calendar-header">W</div>
        <div class="balsamiq-calendar-header">T</div>
        <div class="balsamiq-calendar-header">F</div>
        <div class="balsamiq-calendar-header">S</div>
      </div>
      EOF
      calendar.each do |row|
        @html_body += <<-EOF        
      <div class="balsamiq-calendar-rowdiv" style="font-size:7pt; width:100%; height: #{rowh}%; outline: none">
        <div class="balsamiq-calendar-spacer"></div>
        <div class="balsamiq-calendar-element">#{row[0..1]}</div>
        <div class="balsamiq-calendar-element">#{row[3..4]}</div>
        <div class="balsamiq-calendar-element">#{row[6..7]}</div>
        <div class="balsamiq-calendar-element">#{row[9..10]}</div>
        <div class="balsamiq-calendar-element">#{row[12..13]}</div>
        <div class="balsamiq-calendar-element">#{row[15..16]}</div>
        <div class="balsamiq-calendar-element">#{row[18..19]}</div>
      </div>
        EOF
      end
    @html_body += <<-EOF        
    </div>
    EOF
    unless @css.match("balsamiq_calendar")
      @css += <<-EOF

.balsamiq-calendar-spacer {
  float: left;
  width:9%; 
  height: 100%; 
  outline: none
}

.balsamiq-calendar-element, .balsamiq-calendar-header {
  float: left;
  width:12%; 
  height: 100%; 
  outline: none
}

.balsamiq-calendar-element:hover {
  background-color: #AAEEBB;
}

.balsamiq-calendar-caption a {
  color:#010101;
  text-decoration: none;
}
    EOF
    end  
  end  
end
