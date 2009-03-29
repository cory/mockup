#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_CallOut method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_CallOut(c)
    color = c[:color] ? c[:color] : "rgba(252,251,94,1.0)"
    alpha = c[:backgroundAlpha] ? c[:backgroundAlpha] : "1.0"
    color.gsub!("1.0", alpha)
    text = CGI::unescape(c[:text])
    text = text.split("\n").inject("") {|s,e| s += "<p>#{e}</p>" }
    
    # fix messed up export of width
    c[:w] = -1 if c[:w] == 38
    # note first text is included solely to properly size div (and then canvas)
    @html_header += <<-EOF
      addLoadEvent(function() {draw_callout("#{c[:controlTypeID]}#{c[:controlID]}", "#{c[:controlTypeID]}#{c[:controlID]}canvas", "#{color}", "#{alpha}")});

    EOF
    
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; font-size:10pt; text-align: left; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; 
               padding:5px; outline: none; color: #010101; background-color: transparent; z-index: #{c[:zOrder]}">
      #{text}
      <canvas height=200 width=300 id="#{c[:controlTypeID]}#{c[:controlID]}canvas" style="position: absolute;">
      </canvas>
      <div id="#{c[:controlTypeID]}#{c[:controlID]}text"
          style="position: absolute; font-size:10pt; text-align: left; left: 0px; top: 0px; width: #{c[:w]}px; 
                 padding:5px; outline: none; color: #010101; background-color: transparent; z-index: #{c[:zOrder]}">
        #{text}
      </div>
    </div>
        EOF
    unless @js.match("draw_callout")
      @js += <<-EOF

function draw_callout(divid, canvasid, color, alpha)
{
	var divel = document.getElementById(divid);
	var width = divel.offsetWidth + 20;
	var height = divel.offsetHeight + 20;
	var zindex = parseInt(divel.style.zIndex);

	var canvasel = document.getElementById(canvasid);
	canvasel.style.position = "absolute";
	canvasel.style.top = "-10px";
	canvasel.style.left = "-10px";
	
	canvasel.width = width;
	canvasel.height = height;
	canvasel.style.width = width + "px";
	canvasel.style.height = height + "px";
	var ctx = canvasel.getContext('2d');
  ctx.fillStyle = color;
  ctx.strokeStyle = "rgba(0,0,0," + alpha + ")";
  ctx.lineWidth = 4;
  ctx.lineCap = "round";
 	ctx.moveTo(width*0.05,height*0.05);
	ctx.quadraticCurveTo(width*0.25,0, width*0.90,height*0.05);
	ctx.quadraticCurveTo(width,height*0.5, width*0.90,height*0.95);
	ctx.quadraticCurveTo(width*0.5,height, width*0.05,height*0.95);
	ctx.quadraticCurveTo(0,height*0.75, width*0.05, height*0.05);	
  ctx.fill();
  ctx.stroke();
}
    EOF
    end
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
