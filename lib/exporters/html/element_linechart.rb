#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_LineChart method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_LineChart(c)
    # properly add text to @html_header, @html_body @css, @js 
    jsondata = [["#FF0101",0,0.6,0.4,0.8],["#0101FF",0.3,0.4,0.8,0.6]].to_json
    unless @html_preamble.match("prototype")
      @html_preamble += <<-EOF
      <script type = "text/javascript" src="prototype.js"> </script>
    EOF
    end

    @html_body += <<-EOF
    <div class="#{c[:controlIDType]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; font-size:10pt; text-align: left; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; 
               padding:5px; outline: none; color: #010101; background-color: transparent; z-index: #{c[:zOrder]}">
     <canvas id="#{c[:controlTypeID]}#{c[:controlID]}canvas" width="#{c[:w]}" height="#{c[:h]}">
     </canvas>
    </div>
        EOF

    @html_header += <<-EOF
      addLoadEvent(function() {draw_linechart("#{c[:controlTypeID]}#{c[:controlID]}canvas", #{c[:w]}, #{c[:h]}, '#{jsondata}')});

    EOF
        unless @js.match("draw_linechart")
          @js += <<-EOF

function draw_linechart(canvasid, w, h, json)
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
  var itypes = graphdata.length;
  // first item is color
  var items = graphdata[0].length - 1;

  ctx.lineWidth = 2;
  var percent = 1.0/(items-1);

  var itype;
  var item;

  for (itype = 0; itype < itypes; itype++)
  {
    ctx.strokeStyle = graphdata[itype][0];
    ctx.beginPath();
    ctx.moveTo(4,h*(1-graphdata[itype][1]));
    for (item = 2; item <= items; item++)
    {
      ctx.lineTo((item-1)*percent*w,h*(1-graphdata[itype][item]));
    }
    ctx.stroke();
  }
}
        EOF
    end
  end
end
