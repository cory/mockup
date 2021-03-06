#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# loads elements and adds methods via files in html subdirectory
# grabs the 960grid reset css
# default is BalsamiqExportDefaultHTML
# exceptions are BalsamiqExportAccordianHTML
# etc

require 'cgi'

class BalsamiqExportHTML  
  attr_accessor :filename, :html_preamble, :html_header, :html_body, :html_footer, :css_reset, :css, :js_basic, :js

  def initialize
    load_element_exporter
  end

  def load_element_exporter
    libdir = File.dirname(__FILE__)
    pattern = File.join(libdir, "html", "*.rb")
    Dir.glob(pattern).each {|file| require file}
  end
  
  def start(filename)
    @filename = filename
    
    @html_preamble = <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<!-- Generated by Balsamiq Exporter -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <link rel="stylesheet" type="text/css" href="reset.css" />
    EOF
    
    @html_header = <<-QQQ
    <title>Balsamiq</title>
    <script type="text/javascript">
    QQQ
    
    @html_body = "    </script>\n  </head>\n\n  <body>\n"
    
    @html_footer = <<-EOF
  </body>
</html>
    EOF
    
    @css_reset = <<-EOF
/* Generated by Balsamiq Exporter */
* {
  vertical-align: baseline;
  font-weight: inherit;
  font-family: inherit;
  font-style: inherit;
  font-size: 100%;
  border: 0 none;
  outline: 0;
  padding: 0;
  margin: 0;
}

strong, b {
  font-weight:bold;
}

em, i {
  font-style:italic;
}

body {
  background-color: #f8f4ed;
  font-family: "Comic Sans MS", Arial,sans-serif;
  color: #010101;
}

div {
  background-color: #ffffff;
  outline: 2px solid #202028;
  text-align: center;
}

a {
  color:#0101ff;
}

a:link {
  color:#0101ff;
}

a:hover {
  color:#FD0101;
}
    EOF
    
    @css = ""
    
    @js_basic = <<-EOF
/* Generated by Balsamiq Exporter
/* Simon Willison's cool hack to build out multiple onload events */
function addLoadEvent(func) 
{
  var oldonload = window.onload;
  if (typeof window.onload != 'function') 
  {
    window.onload = func;
  } 
  else 
  {
    window.onload = function() 
    {
      if (oldonload) 
      {
        oldonload();
      }
      func();
    }
  }
}
EOF
    @js = ""
  end
  
  def finish
    File.open("reset.css", "w") { |file| file.puts @css_reset}
    unless @css == ""
      @html_preamble += <<-EOF
      <link rel="stylesheet" type="text/css" href="#{@filename}.css" />
      EOF
      File.open("#{@filename}.css", "w") { |file| file.puts @css}
    end
    File.open("basic.js", "w") { |file| file.puts @js_basic}
    unless @js == ""
      @html_preamble += <<-EOF
      <script type = "text/javascript" src="basic.js"> </script>
      <script type = "text/javascript" src="#{@filename}.js"> </script>
      EOF
      File.open("#{@filename}.js", "w") { |file| file.puts @js}
    end
    File.open("#{@filename}.html", "w") { |file| file.puts @html_preamble + @html_header + @html_body + @html_footer}
  end

  def method_missing(meth, *args)
    c = args[0]
    @html_body += <<-EOF
    <div
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; 
        width: #{c[:w]}px; height: #{c[:h]}px;>
      <h3>#{c[:controlTypeID]}</h3>
      <p>#{c[:text] ? CGI::unescape(c[:text]) : ""} </p>
    </div>
    EOF
  end
  
  def make_buttons(type, id, labels, x, y, h, w, z, vertical = false)
    # properly add text to @html_header, @html_body @css, @js 
    if vertical
      @html_body += <<-EOF
      <div class="#{type}" id="#{type}#{id}"
            style="position: absolute; left: #{x}px; top: #{y}px; width: #{w}px; z-index: #{z};
            font-size:10pt; outline: none; background-color: transparent;">
              EOF
      count = 0
      labels.each do |label|
        @html_body += <<-EOF
        <div class="#{type}" id="#{type}#{id}_#{count}"
            style="float: left; height: #{h}px; width: 100%; outline: none; padding-right:3px; background-color: transparent;">
          <div class="balsamiq_shadow"
            style="position: relative; top: 3px; left: 3px; z-index: #{z};
                   font-size:10pt; height: #{h-3}px; outline: 2px solid #010101; background-color:#010101;">
            <p style="padding-left:10px;padding-right:10px;">#{label}</p>
          </div>
          <div class="balsamiq_button"
            style = "position: relative; z-index: #{z+1};
               font-size:10pt; top: -#{h}px; height: #{h-3}px;">
            <a href=""><p style="padding-left:10px;padding-right:10px;">#{label}</p></a>
          </div>
        </div>
      EOF
        count += 1
      end
      @html_body += <<-EOF
      </div>
      EOF
    else
      @html_body += <<-EOF
      <div class="#{type}" id="#{type}#{id}"
            style="position: absolute; left: #{x}px; top: #{y}px; height: #{h}px; z-index: #{z};
            font-size:10pt; outline: none; background-color: transparent;">
              EOF
      count = 0
      labels.each do |label|
        @html_body += <<-EOF
        <div class="#{type}" id="#{type}#{id}_#{count}"
            style="float: left; height: #{h}px; outline: none; padding-right:3px; background-color: transparent;">
          <div class="balsamiq_shadow"
            style="position: relative; top: 3px; left: 3px; z-index: #{z};
                   font-size:10pt; height: #{h-3}px; outline: 2px solid #010101; background-color:#010101;">
            <p style="padding-left:10px;padding-right:10px;">#{label}</p>
          </div>
          <div class="balsamiq_button"
            style = "position: relative; z-index: #{z+1};
               font-size:10pt; top: -#{h}px; height: #{h-3}px;">
            <a href=""><p style="padding-left:10px;padding-right:10px;">#{label}</p></a>
          </div>
        </div>
      EOF
        count += 1
      end
      @html_body += <<-EOF
      </div>
      EOF
    end
    unless @css.match("balsamiq_button")
      @css += <<-EOF
.balsamiq_button a, a:hover, a:active {
  text-decoration: none;
  color: #010101;
}

.balsamiq_button:hover {
  background-color: #CCCCCC;
}

.balsamiq_button:active {
  background-color: #AAEEBB;
  margin-top: 2px;
}
    EOF
    end  
  end
  
  def get_text_properties(c)
    bold = c[:bold] != "false" ? true : false
    italic =  c[:italic] != "true" ? false : true
    underline = c[:underline] != "true" ? false : true
    size = c[:size] ? "#{c[:size].to_i-3}pt" : "9pt"
    color = c[:color] ? c[:color] : "#010101"
    align = c[:align] ? c[:align] : "center"
    [bold, italic, underline, size, color, align]
  end
  
  def modify_text(t, bold, italic, underline)
    opentag = (bold ? "<b>" : "") + (italic ? "<i>" : "") + (underline ? "<u>" : "")
    closetag = (underline ? "</u>" : "") + (italic ? "</i>" : "") + (bold ? "</b>" : "")
    opentag + t + closetag
  end
  
  def text2row(text, header, bold, italic, underline)
    table = ""
    rows = text.split("\n")
    count = 0
    rows.each do |line|
      textarray = line.split(', ')
      if header
        row = textarray.inject('') {|r,e| r += "<th>#{modify_text(e, bold, italic, underline)}</th>"}
        row = "<tr class='header'>" + row + "</tr>"
        header = false
      else
        row = textarray.inject('') {|r,e| r += "<td>#{modify_text(e, bold, italic, underline)}</td>"}
        row = "<tr class='row#{count % 2}'>" + row + "</tr>"
        count += 1
      end
      table += row
    end
    table
  end
end
