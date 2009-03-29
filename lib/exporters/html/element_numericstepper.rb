#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_NumericStepper method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_NumericStepper(c)
    # properly add text to @html_header, @html_body @css, @js 
    text = CGI::unescape(c[:text])
    c[:h] -= 4
    button_width = 15
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}";
        style="position: absolute; font-size:12px; text-align: left; left: #{c[:x]}px; top: #{c[:y]}px; width: #{c[:w]}px; height: #{c[:h]}px;
        z-index: #{c[:zOrder]}; overflow: hidden;">
        <p style="margin-left: 8px; margin-top: 2px;">#{text}</p>
      <div class="#{c[:controlTypeID]}button" id="#{c[:controlTypeID]}#{c[:controlID]}up";
          style="position: absolute; font-size:11px; text-align: center; left: #{c[:w] - button_width}px; top: 0px; width: #{button_width}px; height: #{c[:h]/2}px;
          z-index: #{c[:zOrder]};" onclick="Spinner.up('#{c[:controlTypeID]}#{c[:controlID]}');">
        <div style="position: relative; top: -3px; background-color: transparent; outline: none; z-index: #{c[:zOrder]};">
          <p><a>+</a></p>
        </div>
      </div>
      <div class="#{c[:controlTypeID]}button" id="#{c[:controlTypeID]}#{c[:controlID]}down";
          style="position: absolute; font-size:11px; text-align: center; left: #{c[:w] - button_width}px; top: #{c[:h]/2}px; width: #{button_width}px; height: #{c[:h]/2}px;
          z-index: #{c[:zOrder]};" onclick="Spinner.down('#{c[:controlTypeID]}#{c[:controlID]}');">
        <div style="position: relative; top: -3px; background-color: transparent; outline: none; z-index: #{c[:zOrder]};">
          <p><a>-</a></p>
        </div>
      </div>
    </div>
    EOF
    unless @css.match("#{c[:controlTypeID]}button")
      @css += <<-EOF
      
.#{c[:controlTypeID]}button a, a:hover, a:active {
  text-decoration: none;
  color: #010101;
}

.#{c[:controlTypeID]}button:hover {
  background-color: #CCCCCC;
}

.#{c[:controlTypeID]}button:active {
  background-color: #AAEEBB;
  margin-top: 2px;
}
    EOF
    end  
    unless @js.match("Spinner")
      @js += <<-EOF

var Spinner =
{
  foo : "",
  up : function(id)
  {
    var div = document.getElementById(id);
    var elem = div.getElementsByTagName("p");
    var value = elem[0].innerText;
    value = parseInt(value);
    value++;
    elem[0].innerText = value.toString();
  },
  down : function(id)
  {
    var div = document.getElementById(id);
    var elem = div.getElementsByTagName("p");
    var value = elem[0].innerText;
    value = parseInt(value);
    value--;
    elem[0].innerText = value.toString();
  },
}
    EOF
    end
  end  
end
