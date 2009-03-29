#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_PieChart method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_PieChart(c)
    # properly add text to @html_header, @html_body @css, @js 
    jsondata = ["#0101FF",0.65,"#FF0101",0.35].to_json
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
      addLoadEvent(function() {draw_piechart("#{c[:controlTypeID]}#{c[:controlID]}canvas", #{c[:w]}, #{c[:h]}, '#{jsondata}')});

    EOF
        unless @js.match("draw_piechart")
          @js += <<-EOF

function draw_piechart(canvasid, w, h, json)
{
	var canvasel = document.getElementById(canvasid);
	var ctx = canvasel.getContext('2d');

  ctx.strokeStyle = "rgba(0,0,0,1.0)";
  ctx.lineWidth = 4;
  ctx.lineCap = "round";

  var graphdata = json.evalJSON(true);
  var values = graphdata.length;
  // first item is color
  var numvalues = graphdata[0].length - 1;

  ctx.lineWidth = 2;
  var radius = Math.min(w-2,h-2)*0.5;
  
  var value;
  var total = Math.PI*1.5;
  var next;

  for (value = 0; value < values; value += 2)
  {
    ctx.fillStyle = graphdata[value];
    ctx.beginPath();
    next = graphdata[value+1]*2*Math.PI;
    ctx.moveTo(w*0.5,h*0.5);
    ctx.arc(w*0.5,h*0.5,radius,total,total+next, false);
    ctx.moveTo(w*0.5,h*0.5);
    total += next;
    ctx.closePath();
    ctx.fill();
    ctx.stroke();
  }
}
        EOF
    end
  end
end
