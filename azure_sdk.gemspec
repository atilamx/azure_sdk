# encoding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'azure_sdk/version'

Gem::Specification.new do |s|
  s.name         = "AzureSdk"
  s.version      = AzureSdk::VERSION
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Manuel Gutierrez"]
  s.email        = ["manuel.gutierrez@michelada.com"]
  s.homepage     = "https://github.com/atilamx/rusql.git"
  s.summary      = "Missing Ruby SDK for Azure"
  s.description  = %q{Missing Ruby SDK for Azure written entirely in ruby just for fun}

  s.required_rubygems_version = ">= 1.3.6"
  s.license = 'MIT'

  s.add_dependency('ethon', [">= 0.9.0"])

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
end

