#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_ProgressBar method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_ProgressBar(c)
    # properly add text to @html_header, @html_body @css, @js 
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}";
        style="position: absolute; font-size:12px; text-align: left; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]-4}px;
        z-index: #{c[:zOrder]}; overflow: hidden;">
      <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}bar";
          style="position: absolute; font-size:12px; text-align: left; left: 0px; top: 0px; height: #{c[:h]-4}px;
          z-index: #{c[:zOrder]}; background-color: #AAEEBB; overflow: hidden;">
      </div>
    </div>
    EOF
    
    @html_header += <<-EOF
      addLoadEvent(function() {ProgressBar.setup("#{c[:controlTypeID]}#{c[:controlID]}bar", #{c[:w]}, 0)});

    EOF
    unless @js.match("ProgressBar")
      @js += <<-EOF

var ProgressBar =
{
  setup : function(id, width, percent)
  {
    var div = document.getElementById(id);
    setTimeout(function() {ProgressBar.update(div, width, percent)}, 1);
  },
  update : function(div, width, percent)
  {
    div.style.width = parseInt(percent*width/100.0) + "px";
    if (percent < 100)
    {
      percent++;
      setTimeout(function() {ProgressBar.update(div, width + 1, percent)}, 50);
    }
  },
}
    EOF
    end
  end  
end
