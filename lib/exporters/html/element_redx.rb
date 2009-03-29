#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_RedX method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_RedX(c)
    # create a canvas tag, javascript, draw an arrow following the appropriate rules
    @html_header += <<-EOF
      addLoadEvent(function() {draw_redx("#{c[:controlTypeID]}#{c[:controlID]}canvas", #{c[:w]}, #{c[:h]})});

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
    unless @js.match("draw_redx")
      @js += <<-EOF

function draw_redx(id, width, height)
{
  var canvas = document.getElementById(id);
  var ctx = canvas.getContext('2d');
  ctx.strokeStyle = "RGBA(120,22,29,1.0)";
  ctx.lineWidth = 16;
  ctx.lineCap = "round";
	ctx.moveTo(10,10);
	ctx.lineTo(width - 10,height - 10);
	ctx.moveTo(10,height-10);
	ctx.lineTo(width-10,10);
	ctx.stroke();
}
    EOF
    end
  end
end
