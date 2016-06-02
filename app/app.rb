require 'sinatra'

class App < Sinatra::Base

	get '/hi' do
		"Hello World!"
	end

end