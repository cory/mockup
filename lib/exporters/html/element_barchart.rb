#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_BarChart method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_BarChart(c)
    # properly add text to @html_header, @html_body @css, @js 
    jsondata = [["#FF0101",0.45,0.8],["#0101FF",0.6,0.7]].to_json
    unless @html_preamble.match("prototype")
      @html_preamble += <<-EOF
      <script type = "text/javascript" src="prototype.js"> </script>
    EOF
    end

    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; font-size:10pt; text-align: left; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; 
               padding:5px; outline: none; color: #010101; background-color: transparent; z-index: #{c[:zOrder]}">
     <canvas id="#{c[:controlTypeID]}#{c[:controlID]}canvas" width="#{c[:w]}" height="#{c[:h]}">
     </canvas>
    </div>
        EOF
        
    @html_header += <<-EOF
      addLoadEvent(function() {draw_barchart("#{c[:controlTypeID]}#{c[:controlID]}canvas", #{c[:w]}, #{c[:h]}, '#{jsondata}')});

    EOF
    unless @js.match("draw_barchart")
      @js += <<-EOF

function draw_barchart(canvasid, w, h, json)
{
	var canvasel = document.getElementById(canvasid);
	var ctx = canvasel.getContext('2d');

  ctx.fillStyle = "rgba(0,0,0,1.0)";
  ctx.strokeStyle = "rgba(0,0,0,1.0)";
  ctx.lineWidth = 8;
  ctx.lineCap = "round"; 
  ctx.fillRect(0,0,4,h);
  ctx.fillRect(0,h-4,w,h-4);

  var graphdata = json.evalJSON(true);
  var bars = graphdata.length;
  // first item is color
  var items = graphdata[0].length - 1;

  var percent = 1.0/((bars+1)*items+1);

  ctx.lineWidth = 2;

  var bar;
  var item;
  
  for (item = 1; item <= items; item++)
  {
    for (bar = 0; bar < bars; bar++)
    {
      ctx.fillStyle = graphdata[bar][0];
      ctx.fillRect(2,h*percent*(bar+(item-1)*3+1),w*graphdata[bar][item],percent*h);
      ctx.strokeRect(2,h*percent*(bar+(item-1)*3+1),w*graphdata[bar][item],percent*h);
    }        
  }
}
        EOF
    end
  end
end
