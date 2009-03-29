#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_BreadCrumbs method into BalsamiqExportHTML

class BalsamiqExportHTML
  def text2breadcrumbs(t, bold, italic, underline)
    t = CGI::unescape(t) 
    names = t.split(", ")
    opentag = (bold ? "<strong>" : "") + (italic ? "<em>" : "") + (underline ? "<u>" : "")
    closetag =  (underline ? "</u>" : "") + (italic ? "</em>" : "") + (bold ? "</strong>" : "")
    "#{opentag}<a href=\"\">" + names[0..-2].join("</a>#{closetag} > #{opentag}<a  href=\"\">") + "</a>#{closetag} > #{opentag}" + names[-1] + closetag
  end
  
  def export_BreadCrumbs(c)
    # properly add text to @html_header, @html_body @css, @js 
    style = "position: absolute; left: #{c[:x]}px; top: #{c[:y]}px;  z-index: #{c[:zOrder]}"
    if c[:text]
      if (c[:bold] != "false")
        bold = true
      end
      if (c[:italic])
        italic = true
      end
      if (c[:underline])
        underline = true
      end
      links = text2breadcrumbs(c[:text], bold, italic, underline)
      if (c[:size])
        style += "; font-size:#{c[:size].to_i-2}pt"
      else
        style += "; font-size:11pt"
      end
      @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlID]}"
          style="#{style}">
          #{links}
    </div>
    EOF
      unless @css.match("BreadCrumbs")
        @css += <<-EOF

.#{c[:controlTypeID]} {
background-color: transparent;
outline: none
}
    EOF
      end
    end
  end  
end
