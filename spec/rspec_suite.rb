#!/usr/bin/env ruby  
 
# spec-suite
# Copyright (c) 2009 Cory Ondrejka. All rights reserved.
# See License.txt for licensing details.
 
dir = File.dirname(__FILE__)
Dir["#{dir}/**/*_spec.rb"].reverse.each do |file|
  require file
end