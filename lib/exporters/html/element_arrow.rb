#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Arrow method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_Arrow(c)
    color = c[:color] ? c[:color] : "rgba(32,32,30,1.0)"
    alpha = c[:backgroundAlpha] ? c[:backgroundAlpha] : "1.0"
    color.gsub!("1.0", alpha)
    top = c[:direction] && c[:direction] == "bottom" ? false : true
    left = c[:leftArrow] && c[:leftArrow] == "false" ? false : true
    right = c[:rightArrow] && c[:rightArrow] == "false" ? false : true
    # create a canvas tag, javascript, draw an arrow following the appropriate rules
    if (top)
      astart = "[5,5]"
      aend = "[#{c[:w]-5}, #{c[:h]-5}]"
    else
      astart = "[5, #{c[:h]-5}]"
      aend = "[#{c[:w]-5},5]"
    end
    unless @js.match("draw_arrow")
      @js += <<-EOF

function draw_arrow(id, color, a, b, left, right)
{
  var canvas = document.getElementById(id);
  if (canvas.getContext)
  {
    var c1x, c1y, c2x, c2y;
    var up;
    if (a[1] < b[1])
    {
      up = 1.0;
      c1x = (a[0] + b[0])*0.5;
      c1y = (a[1] + b[1])*0.15;
      c2x = (a[0] + b[0])*0.85;
      c2y = (a[1] + b[1])*0.50;
    }
    else
    {
      up = -1.0;
      c1x = (a[0] + b[0])*0.15;
      c1y = (a[1] + b[1])*0.50;
      c2x = (a[0] + b[0])*0.5;
      c2y = (a[1] + b[1])*0.15;
    }

    var arrow_size = 13;
    var ctx = canvas.getContext('2d');
    ctx.strokeStyle = color;
    ctx.lineWidth = 5;
    ctx.lineCap = "round";
		ctx.moveTo(a[0],a[1]);
		ctx.bezierCurveTo(c1x,c1y,c2x,c2y,b[0],b[1]);
		if (left)
		{
  		ctx.moveTo(a[0],a[1]);
  		ctx.lineTo(a[0] + arrow_size, a[1] - up*0.3*arrow_size);
  		ctx.moveTo(a[0],a[1]);
  		ctx.lineTo(a[0] - 0.2*arrow_size, a[1] + up*arrow_size);
		}
		if (right)
	  {
  		ctx.moveTo(b[0],b[1]);
  		ctx.lineTo(b[0] - arrow_size, b[1] + up*0.3*arrow_size);
  		ctx.moveTo(b[0],b[1]);
  		ctx.lineTo(b[0] - 0.2*arrow_size, b[1] - up*arrow_size);		    
	  }
		ctx.stroke();
  }
}
    EOF
    end
    
    @html_header += <<-EOF
      addLoadEvent(function() {draw_arrow("canvas_#{c[:controlID]}", "#{color}", #{astart}, #{aend}, #{left}, #{right})});

    EOF
    
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlID]}"
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px;  z-index: #{c[:zOrder]}">
      <canvas width="#{c[:w]}" height="#{c[:h]}" id="canvas_#{c[:controlID]}"></canvas>
    </div>
    EOF
    
    unless @css.match("canvas")
      @css += <<-EOF

.#{c[:controlTypeID]} {
	background-color: transparent;
	outline: none
}

canvas {
	background-color: transparent;
}
      EOF
    end
  end
end
