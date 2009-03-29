#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_VCurly method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_VCurly(c)
    # properly add text to @html_header, @html_body @css, @js 
    bold, italic, underline, font, textcolor, align = get_text_properties(c)
    text = CGI::unescape(c[:text])
    textrows = text.split("\n")
    text = textrows.inject("") {|s,e| s += "<p>#{modify_text(e,bold,italic,underline)}</p>\n"}
    left = c[:direction] != "right"

    # fix messed up export of width
    c[:w] = -1 if c[:w] == 38
    # note first text is included solely to properly size div (and then canvas)
    @html_header += <<-EOF
      addLoadEvent(function() {draw_vcurley("#{c[:controlTypeID]}#{c[:controlID]}canvas", #{left})});

    EOF
    
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; font-size:#{font}; text-align: left; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]}px;
               padding:5px; outline: none; color: #010101; background-color: transparent; z-index: #{c[:zOrder]}">
      <canvas width=#{c[:w]}px height=#{c[:h]} id="#{c[:controlTypeID]}#{c[:controlID]}canvas" style="position: absolute;">
      </canvas>
    EOF
    if left
      @html_body += <<-EOF
      <div style="position: absolute; font-size:#{font}; text-align: left; left: 0px; top: 40%; width: #{c[:w]}px; height: 100%;
           padding:5px; outline: none; text-align: center; color: #{textcolor}; background-color: transparent; z-index: #{c[:zOrder]}">
        #{text}
      </div>
    </div>
        EOF
      else
        @html_body += <<-EOF
      <div style="position: absolute; right: 25px;  top: 40%; height: 100%; font-size:#{font}; text-align: center; padding:5px; outline: none; color: #{textcolor}; 
        background-color: transparent; z-index: #{c[:zOrder]}">
        #{text}
      </div>
    </div>
        EOF
      end
    unless @js.match("draw_hcurley")
      @js += <<-EOF

function draw_vcurley(id, left)
{
  var canvasel = document.getElementById(id);
  var height = canvasel.height;
  var width = canvasel.width;
	var ctx = canvasel.getContext('2d');
  ctx.strokeStyle = "rgba(1,1,1,1.0)";
  ctx.lineWidth = 3;
  ctx.lineCap = "round";
  if (left)
  {
   	ctx.moveTo(8,2);
  	ctx.quadraticCurveTo(16,height*0.12, 8,height*0.25);
  	ctx.quadraticCurveTo(0,height*0.375, 18,height*0.5);
  	ctx.quadraticCurveTo(0,height*0.625, 8,height*0.75);
  	ctx.quadraticCurveTo(16,height*0.875, 8,height-2);
  }
  else
  {
   	ctx.moveTo(width-8,2);
  	ctx.quadraticCurveTo(width-16,height*0.12, width-8,height*0.25);
  	ctx.quadraticCurveTo(width,height*0.375, width-18,height*0.5);
  	ctx.quadraticCurveTo(width,height*0.625, width-8,height*0.75);
  	ctx.quadraticCurveTo(width-16,height*0.875, width-8,height-2);
  }
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
