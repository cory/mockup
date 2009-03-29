#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


# adds specific export_BrowserWindow method into BalsamiqExportHTML

# <div> for the whole window
#   20% <div> for top bar in gray
#    <div back><div forward><div home><div search>
#   70% <iframe>
#   10% <div> for bottom

class BalsamiqExportHTML
  def export_BrowserWindow(c)
    # properly add text to @html_header, @html_body @css, @js 
    @html_body += <<-EOF
    <div class="#{c[:controlTypeID]}" id="#{c[:controlTypeID]}#{c[:controlID]}" 
        style="position: absolute; left: #{c[:x]}px; top: #{c[:y]}px; 
        width: #{c[:w]}px; height: #{c[:h]}px; z-index: #{c[:zOrder]};background-color:#CCCCCC;}">
        <div style="height:20%; background-color:#CCCCCC; background-color:transparent; outline:none" >
          <div id="#{c[:controlTypeID]}#{c[:controlID]}back" style="background-color:transparent; outline:none; height:100%; width:10%; float:left" onclick="CallStack.back('#{c[:controlTypeID]}#{c[:controlID]}iframe');">
            <p>
              back
            </p>
          </div>
          <div id="#{c[:controlTypeID]}#{c[:controlID]}fwd" style="background-color:transparent; outline:none; height:100%; width:10%; float:left" onclick="CallStack.fwd('#{c[:controlTypeID]}#{c[:controlID]}iframe');">
            <p>
              fwd
            </p>
          </div>
          <div style="background-color:transparent; outline:none; height:100%; width:50%; float:left">
            <p>
              <input name=search type="text" size=20 onKeyPress="CallStack.browser('#{c[:controlTypeID]}#{c[:controlID]}iframe', this,event, false);"></input>
            </p>
          </div>
          <div style="background-color:transparent; outline:none; height:100%; width:30%; float:left">
            <p>
              <input name=search type="text" size=8 onKeyPress="CallStack.browser('#{c[:controlTypeID]}#{c[:controlID]}iframe', this, event, true);"></input>
            </p>
          </div>
        </div>
        <div style="height:70%; background-color:transparent; outline:none;"><iframe  id="#{c[:controlTypeID]}#{c[:controlID]}iframe" height="99%" width="99%" frameborder=0 src="http://google.com"></iframe></div>
        <div style="height:10%; background-color:transparent; outline:none"></div>
    </div>
    EOF
    
    unless @js.match("browser")
      @js += <<-EOF

var CallStack =
{
  visits : {},
  popped : {},
  current : "http://google.com",
  
  timerid : 0,
  
  add : function(id, site)
  {
    if (!this.visits[id])
      this.visits[id] = [];
    this.visits[id].unshift(site);
  },
  
  // fwd means:
  //  current->visited, popped->current
  fwd : function(id)
  {
    if (!this.popped[id])
      this.popped[id] = [];
    if (this.popped[id].length > 0)
    {
      if (!this.visits[id])
        this.visits[id] = [];
      this.visits[id].unshift(this.current);
      this.current = this.popped[id].shift();
      document.getElementById(id).src = this.current;
    }
  },
  
  // back means:
  //  current->popped, visited->current
  back : function(id)
  {
    if (!this.visits[id])
      this.visits[id] = [];
    if (this.visits[id].length > 0)
    {
      if (!this.popped[id])
        this.popped[id] = [];
      this.popped[id].unshift(this.current);
      this.current = this.visits[id].shift();
      document.getElementById(id).src = this.current;
    }
  },
  
  seturl : function(id, url)
  {
    if (this.current != "")
      this.add(id, this.current);
    this.current = url;
    document.getElementById(id).src = url;
  },
  
  browser : function(id, searchform,event,search) 
  {
    var kc;
    if (window.event)
    {
      kc = window.event.keyCode;
    }
    else
    {
      if (event) 
        kc = e.which;
      else 
        return;
    } 

    if (kc == 13)
    {
      if (search)
      {
        var deststr = "http://www.google.com/search?client=safari&rls=en-us&ie=UTF-8&oe=UTF-8&q=" + searchform.value;
        this.seturl(id, deststr);
      }
      else
      {
        var urlexp = /(http|file):////.*/
        var result = urlexp.exec(searchform.value);
        var deststr;
        if (result)
          deststr = escape(searchform.value);
        else
          deststr = "http://" + searchform.value;
        this.seturl(id, deststr);
      }
    }
  }  
}
    EOF
    end
  end  
end
