#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_ScratchOut method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_ScratchOut(c)
       # create a canvas tag, javascript, draw an arrow following the appropriate rules
    @html_header += <<-EOF
      addLoadEvent(function() {draw_scratch_out("#{c[:controlTypeID]}#{c[:controlID]}canvas", #{c[:w]}, #{c[:h]})});

    EOF
    
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; background-color: transparent; outline: none; z-index: #{c[:zOrder]}">
      <canvas width="#{c[:w]}" height="#{c[:h]}" id="#{c[:controlTypeID]}#{c[:controlID]}canvas"></canvas>
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
    unless @js.match("draw_scratch_out")
      @js += <<-EOF

function draw_scratch_out(id, width, height)
{
  var canvas = document.getElementById(id);
  var ctx = canvas.getContext('2d');
  ctx.strokeStyle = "RGBA(1,1,1,1.0)";
  ctx.lineWidth = 8;
  var slope = height/width;
  var diagonal = Math.sqrt(height*height + width*width);
  var i;
  ctx.lineCap = "round";
	ctx.moveTo(0,0);
  var sine;
  for (i = 0; i < diagonal; i++)
  {
    if (i < diagonal/2)
      sine = Math.sin(i/4)*i*0.8;
    else
      sine = Math.sin(i/4)*(diagonal - i)*0.8;
    
    var xoffset = -sine*slope;
    var yoffset = sine*slope;
  	ctx.lineTo(i/diagonal*width + xoffset,i/diagonal*height+yoffset);
  }
	ctx.stroke();
}
    EOF
    end
  end
end
