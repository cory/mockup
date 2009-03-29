#!/usr/bin/env ruby
      
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.


#<mockup version="1.0" skin="sketch">
#  <controls>
#    <control controlID="0" controlTypeID="com.balsamiq.mockups::Accordion" x="100" y="31" w="-1" h="-1" zOrder="0" locked="false" isInGroup="-1">
#      <controlProperties>
#        <text>Item%20One%0AItem%20Two%0AItem%20Three%0AItem%20Four</text>
#      </controlProperties>
#    </control>
#    <control controlID="1" controlTypeID="com.balsamiq.mockups::Arrow" x="278" y="31" w="-1" h="-1" zOrder="1" locked="false" isInGroup="-1"/>
#    ...

require "rubygems"
require 'hpricot'
require "json"
require "#{File.dirname(__FILE__)}/../symbols/balsamiq-control-defaults"

class BalsamiqControl
  XML_PROPERTIES = 
  [
    :align,
    :alternateRowColor,
    :backgroundAlpha,
    :bold,
    :borderStyle,
    :bottomheight,
    :close,
    :color,
    :direction,
    :dragger,
    :hasHeader,
    :hLines,
    :icon,
    :italic,
    :labelPosition,
    :leftArrow,
    :maximizeRestore,
    :minimize,
    :position,
    :rightArrow,
    :rowHeight,
    :selectedIndex,
    :size,
    :state,
    :tabVPosition,
    :text,
    :topheight,
    :underline,
    :verticalScrollbar,
    :vLines
  ]

  def initialize(control)
    @control = Hash.new(nil)
    @control[:controlID] = control.attributes["#{:controlID}"].to_i
    @control[:controlTypeID] = control.attributes["#{:controlTypeID}"].split("::")[1].to_sym
    @control[:x] = control.attributes["#{:x}"].to_i
    @control[:y] = control.attributes["#{:y}"].to_i
    # if the control hasn't changed from default size, size is -1, so fix here
    @control[:w] = control.attributes["#{:w}"].to_i == -1 ? CONTROL_SIZE_DEFAULTS[@control[:controlTypeID]][:w] : control.attributes["#{:w}"].to_i 
    @control[:h] = control.attributes["#{:h}"].to_i == -1 ? CONTROL_SIZE_DEFAULTS[@control[:controlTypeID]][:h] : control.attributes["#{:h}"].to_i 
    @control[:zOrder] = control.attributes["#{:zOrder}"].to_i
    @control[:isInGroup] = control.attributes["#{:isInGroup}"].to_i
    XML_PROPERTIES.each do |prop|
      element = (control/"#{:controlProperties}"/"#{prop}")
      if element[0]
        @control[prop] = (control/"#{:controlProperties}"/"#{prop}")[0].inner_html
        if prop == :color
          @control[:color] = BalsamiqControl::bcolor2web(@control[:color].to_i)
        end
        if prop == :alternateRowColor
          @control[:alternateRowColor] = BalsamiqControl::bcolor2web(@control[:alternateRowColor].to_i)
        end
      else
        @control[prop] = nil
      end
    end
  end


  def self.bcolor2web(color)
    # balsamiq stores color a 24 bit integer
    blue = color % 256
    color /= 256
    green = color % 256
    red = color / 256
    "rgba(#{red},#{green},#{blue},1.0)"
  end

  attr_reader :control

  def test(var)
    @control == var
  end
  
  def to_json
    @control.to_json
  end
end