require 'sinatra'

class HotelApi < Sinatra::Base

	get '/hi' do
		"Hello World!"
	end

end