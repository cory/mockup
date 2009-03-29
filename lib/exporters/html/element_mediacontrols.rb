#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_MediaControls method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_MediaControls(c)
    # properly add text to @html_header, @html_body @css, @js 
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]}px; top: #{c[:y]-18}px;
          font-size:36pt; outline: none; background-color:transparent;">
          O
    </div>
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]+9}px; top: #{c[:y]+8}px;
          font-size:9pt; outline: none; background-color:transparent;">
          RW
    </div>
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]+40}px; top: #{c[:y]-18}px;
          font-size:36pt; outline: none; background-color:transparent;">
          O
    </div>
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]+56}px; top: #{c[:y]+8}px;
          font-size:9pt; outline: none; background-color:transparent;">
          P
    </div>
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]+80}px; top: #{c[:y]-18}px;
          font-size:36pt; outline: none; background-color:transparent;">
          O
    </div>
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
          style="position: absolute; left: #{c[:x]+93}px; top: #{c[:y]+8}px;
          font-size:9pt; outline: none; background-color:transparent;">
          FF
    </div>
    EOF
  end  
end
