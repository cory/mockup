#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# take one or more Balsamiq export elements from the command line
# check to make sure they are within the existing symbols
# and create element files in /html subdirectory

require "#{File.dirname(__FILE__)}/../lib/symbols/balsamiq-control-symbols"

ARGV.each do |element_name|
  if eval "BalsamiqControlSymbols.find_index(:#{element_name})"
    element = <<-EOF    
#!/usr/bin/env ruby

# Copyright (c) #{Time.now.year} Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.

# adds specific export_#{element_name} method into BalsamiqExportHTML

class BalsamiqExportHTML
  def export_#{element_name}(c)
    # properly add text to @html_header, @html_body @css, @js 
  end  
end
    EOF
    unless File.exists?("#{File.dirname(__FILE__)}/../exporters/html/element_#{element_name.downcase}.rb")
      File.open("html/element_#{element_name.downcase}.rb", "w") {|file| file.puts element}
      
      html_spec = File.read("#{File.dirname(__FILE__)}/../spec/html/html-spec.rb")
      html_lines = html_spec.split("\n")
      html_lines[-1] = <<-QQQ
      
  it "properly handles #{element_name.downcase}" do
    data = <<-EOF
    EOF
    html = <<-EOF
    EOF
    css = <<-EOF
    EOF
    js = <<-EOF
    EOF
    filename = "#{element_name.downcase}"
    test_elements(filename, data, html, css, js, true)
  end
end
      QQQ
      File.open("#{File.dirname(__FILE__)}/../spec/html/html-spec.rb","w") {|file| file.puts html_lines.join("\n")}
    end
  end
end
