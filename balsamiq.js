
function draw_arrow(id, color, a, b, left, right)
{
  var canvas = document.getElementById(id);
  if (canvas.getContext)
  {
    var c1x, c1y, c2x, c2y;
    var up;
    if (a[1] < b[1])
    {
      up = 1.0;
      c1x = (a[0] + b[0])*0.5;
      c1y = (a[1] + b[1])*0.15;
      c2x = (a[0] + b[0])*0.85;
      c2y = (a[1] + b[1])*0.50;
    }
    else
    {
      up = -1.0;
      c1x = (a[0] + b[0])*0.15;
      c1y = (a[1] + b[1])*0.50;
      c2x = (a[0] + b[0])*0.5;
      c2y = (a[1] + b[1])*0.15;
    }

    var arrow_size = 13;
    var ctx = canvas.getContext('2d');
    ctx.strokeStyle = color;
    ctx.lineWidth = 5;
    ctx.lineCap = "round";
		ctx.moveTo(a[0],a[1]);
		ctx.bezierCurveTo(c1x,c1y,c2x,c2y,b[0],b[1]);
		if (left)
		{
  		ctx.moveTo(a[0],a[1]);
  		ctx.lineTo(a[0] + arrow_size, a[1] - up*0.3*arrow_size);
  		ctx.moveTo(a[0],a[1]);
  		ctx.lineTo(a[0] - 0.2*arrow_size, a[1] + up*arrow_size);
		}
		if (right)
	  {
  		ctx.moveTo(b[0],b[1]);
  		ctx.lineTo(b[0] - arrow_size, b[1] + up*0.3*arrow_size);
  		ctx.moveTo(b[0],b[1]);
  		ctx.lineTo(b[0] - 0.2*arrow_size, b[1] - up*arrow_size);		    
	  }
		ctx.stroke();
  }
}

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

function draw_barchart(canvasid, w, h, json)
{
	var canvasel = document.getElementById(canvasid);
	var ctx = canvasel.getContext('2d');

  ctx.fillStyle = "rgba(0,0,0,1.0)";
  ctx.strokeStyle = "rgba(0,0,0,1.0)";
  ctx.lineWidth = 8;
  ctx.lineCap = "round"; 
  ctx.fillRect(0,0,4,h);
  ctx.fillRect(0,h-4,w,h-4);

  var graphdata = json.evalJSON(true);
  var bars = graphdata.length;
  // first item is color
  var items = graphdata[0].length - 1;

  var percent = 1.0/((bars+1)*items+1);

  ctx.lineWidth = 2;

  var bar;
  var item;
  
  for (item = 1; item <= items; item++)
  {
    for (bar = 0; bar < bars; bar++)
    {
      ctx.fillStyle = graphdata[bar][0];
      ctx.fillRect(2,h*percent*(bar+(item-1)*3+1),w*graphdata[bar][item],percent*h);
      ctx.strokeRect(2,h*percent*(bar+(item-1)*3+1),w*graphdata[bar][item],percent*h);
    }        
  }
}

function draw_columnchart(canvasid, w, h, json)
{
	var canvasel = document.getElementById(canvasid);
	var ctx = canvasel.getContext('2d');

  ctx.fillStyle = "rgba(0,0,0,1.0)";
  ctx.strokeStyle = "rgba(0,0,0,1.0)";
  ctx.lineWidth = 8;
  ctx.lineCap = "round";
  ctx.fillRect(0,0,4,h);
  ctx.fillRect(0,h-4,w,h-4);

  var graphdata = json.evalJSON(true);
  var bars = graphdata.length;
  // first item is color
  var items = graphdata[0].length - 1;

  var percent = 1.0/((bars+1)*items+1);

  ctx.lineWidth = 2;

  var bar;
  var item;
  
  for (item = 1; item <= items; item++)
  {
    for (bar = 0; bar < bars; bar++)
    {
      ctx.fillStyle = graphdata[bar][0];
      ctx.fillRect(w*percent*(bar+(item-1)*3+1),h*(1.0-graphdata[bar][item]),percent*w,h*graphdata[bar][item]-2);
      ctx.strokeRect(w*percent*(bar+(item-1)*3+1),h*(1.0-graphdata[bar][item]),percent*w,h*graphdata[bar][item]-2);
    }        
  }
}

function draw_linechart(canvasid, w, h, json)
{
	var canvasel = document.getElementById(canvasid);
	var ctx = canvasel.getContext('2d');

  ctx.fillStyle = "rgba(0,0,0,1.0)";
  ctx.strokeStyle = "rgba(0,0,0,1.0)";
  ctx.lineWidth = 8;
  ctx.lineCap = "round";
  ctx.fillRect(0,0,4,h);
  ctx.fillRect(0,h-4,w,h-4);

  var graphdata = json.evalJSON(true);
  var itypes = graphdata.length;
  // first item is color
  var items = graphdata[0].length - 1;

  ctx.lineWidth = 2;
  var percent = 1.0/(items-1);

  var itype;
  var item;

  for (itype = 0; itype < itypes; itype++)
  {
    ctx.strokeStyle = graphdata[itype][0];
    ctx.beginPath();
    ctx.moveTo(4,h*(1-graphdata[itype][1]));
    for (item = 2; item <= items; item++)
    {
      ctx.lineTo((item-1)*percent*w,h*(1-graphdata[itype][item]));
    }
    ctx.stroke();
  }
}

function draw_piechart(canvasid, w, h, json)
{
	var canvasel = document.getElementById(canvasid);
	var ctx = canvasel.getContext('2d');

  ctx.strokeStyle = "rgba(0,0,0,1.0)";
  ctx.lineWidth = 4;
  ctx.lineCap = "round";

  var graphdata = json.evalJSON(true);
  var values = graphdata.length;
  // first item is color
  var numvalues = graphdata[0].length - 1;

  ctx.lineWidth = 2;
  var radius = Math.min(w-2,h-2)*0.5;
  
  var value;
  var total = Math.PI*1.5;
  var next;

  for (value = 0; value < values; value += 2)
  {
    ctx.fillStyle = graphdata[value];
    ctx.beginPath();
    next = graphdata[value+1]*2*Math.PI;
    ctx.moveTo(w*0.5,h*0.5);
    ctx.arc(w*0.5,h*0.5,radius,total,total+next, false);
    ctx.moveTo(w*0.5,h*0.5);
    total += next;
    ctx.closePath();
    ctx.fill();
    ctx.stroke();
  }
}

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

var ProgressBar =
{
  setup : function(id, width, percent)
  {
    var div = document.getElementById(id);
    setTimeout(function() {ProgressBar.update(div, width, percent)}, 1);
  },
  update : function(div, width, percent)
  {
    div.style.width = parseInt(percent*width/100.0) + "px";
    if (percent < 100)
    {
      percent++;
      setTimeout(function() {ProgressBar.update(div, width + 1, percent)}, 50);
    }
  },
}

function draw_redx(id, width, height)
{
  var canvas = document.getElementById(id);
  var ctx = canvas.getContext('2d');
  ctx.strokeStyle = "RGBA(120,22,29,1.0)";
  ctx.lineWidth = 16;
  ctx.lineCap = "round";
	ctx.moveTo(10,10);
	ctx.lineTo(width - 10,height - 10);
	ctx.moveTo(10,height-10);
	ctx.lineTo(width-10,10);
	ctx.stroke();
}

function draw_scratch_out(id, width, height)
{
  var canvas = document.getElementById(id);
  var ctx = canvas.getContext('2d');
  ctx.strokeStyle = "RGBA(1,1,1,1.0)";
  ctx.lineWidth = 8;
  var slope = height/width;
  var diagonal = Math.sqrt(height*height + width*width);
  var i;
  ctx.lineCap = "round";
	ctx.moveTo(0,0);
  var sine;
  for (i = 0; i < diagonal; i++)
  {
    if (i < diagonal/2)
      sine = Math.sin(i/4)*i*0.8;
    else
      sine = Math.sin(i/4)*(diagonal - i)*0.8;
    
    var xoffset = -sine*slope;
    var yoffset = sine*slope;
  	ctx.lineTo(i/diagonal*width + xoffset,i/diagonal*height+yoffset);
  }
	ctx.stroke();
}

function initialize_gmap(id)
{
  if (GBrowserIsCompatible()) 
  {
    var map = new GMap2(document.getElementById(id));
    map.setCenter(new GLatLng(37.4419, -122.1419), 13);
  }
}
