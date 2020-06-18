#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'byebug'
require 'azure_sdk'
require 'azure_sdk/services'
require 'azure_sdk/virtual_machines'

class Raz 
  def start
    a = AzureSdk::VirtualMachines.new 
    a.test 
  end

  def start_logger
  end
end

raz = Raz.new
raz.start

