#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_HCurly method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_HCurly(c)
    # properly add text to @html_header, @html_body @css, @js 
    bold, italic, underline, font, textcolor, align = get_text_properties(c)
    text = CGI::unescape(c[:text])
    textrows = text.split("\n")
    text = textrows.inject("") {|s,e| s += "<p>#{modify_text(e,bold,italic,underline)}</p>\n"}
    top = c[:direction] != "bottom"
    
    # fix messed up export of width
    c[:w] = -1 if c[:w] == 38
    # note first text is included solely to properly size div (and then canvas)
    @html_header += <<-EOF
      addLoadEvent(function() {draw_hcurley("#{c[:controlTypeID]}#{c[:controlID]}canvas", #{top})});

    EOF
    
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}"
        style="position: absolute; font-size:#{font}; text-align: left; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]}px;
               padding:5px; outline: none; color: #010101; background-color: transparent; z-index: #{c[:zOrder]}">
      <canvas width=#{c[:w]}px height=#{c[:h]} id="#{c[:controlTypeID]}#{c[:controlID]}canvas" style="position: absolute;">
      </canvas>
    EOF
    
    if top
      @html_body += <<-EOF
      <div style="position: absolute; font-size:#{font}; text-align: left; left: 0px; top: 25px; width: 100%; height: #{c[:h]}px;
           padding:5px; outline: none; text-align: center; color: #{textcolor}; background-color: transparent; z-index: #{c[:zOrder]}">
        #{text}
      </div>
    </div>
        EOF
      else
        @html_body += <<-EOF
      <div style="position: absolute; bottom: 25px; width: 100%; font-size:#{font}; text-align: center; padding:5px; outline: none; color: #{textcolor}; 
        background-color: transparent; z-index: #{c[:zOrder]}">
        #{text}
      </div>
    </div>
        EOF
      end
    unless @js.match("draw_hcurley")
      @js += <<-EOF

function draw_hcurley(id, top)
{
  var canvasel = document.getElementById(id);
  var height = canvasel.height;
  var width = canvasel.width;
	var ctx = canvasel.getContext('2d');
  ctx.strokeStyle = "rgba(1,1,1,1.0)";
  ctx.lineWidth = 3;
  ctx.lineCap = "round";
  if (top)
  {
   	ctx.moveTo(2,8);
  	ctx.quadraticCurveTo(width*0.12,16, width*0.25,8);
  	ctx.quadraticCurveTo(width*0.375,0, width*0.5,18);
  	ctx.quadraticCurveTo(width*0.625,0, width*0.75,8);
  	ctx.quadraticCurveTo(width*0.875,16, width-2,8);
  }
  else
  {
   	ctx.moveTo(2,height-8);
  	ctx.quadraticCurveTo(width*0.12,height-16, width*0.25,height-8);
  	ctx.quadraticCurveTo(width*0.375,height, width*0.5,height-18);
  	ctx.quadraticCurveTo(width*0.625,height, width*0.75,height-8);
  	ctx.quadraticCurveTo(width*0.875,height-16, width-2,height-8);
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
