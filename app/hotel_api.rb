require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

class Hotel < ActiveRecord::Base
end

class HotelApi < Sinatra::Base
	register Sinatra::ActiveRecordExtension

	# GET all the hotels
	get '/' do
		[200, Hotel.all.to_json]
	end


end