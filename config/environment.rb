require 'rubygems'
require 'bundler'

Bundler.require
Bundler.require(Sinatra::Base.environment)

require './app/hotel_api.rb'