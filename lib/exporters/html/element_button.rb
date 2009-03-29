#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_Button method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_Button(c)
    # properly add text to @html_header, @html_body @css, @js 
    label = CGI::unescape(c[:text])
    make_buttons(c[:controlTypeID], c[:controlID], [label], c[:x], c[:y], c[:h], c[:w], c[:zOrder], false)
  end
end
