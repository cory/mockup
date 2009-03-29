#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_ButtonBar method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_ButtonBar(c)
    # properly add text to @html_header, @html_body @css, @js 
    labeltext = CGI::unescape(c[:text])
    labels = labeltext.split(", ")
    make_buttons(c[:controlTypeID], c[:controlID], labels, c[:x], c[:y], c[:h], c[:w], c[:zOrder], false)
  end
end
