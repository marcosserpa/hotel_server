require 'rubygems'
require 'bundler'

Bundler.require
Bundler.require(Sinatra::Base.environment)

require './app/app.rb'