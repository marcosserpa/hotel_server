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

	# GET a hotel by ID
	get '/hotels/:id' do
		return [404, {}, "<h1>Not Found</h1>"] if hotel.nil?

		hotel.to_json
	end

	# GET hotel(s) by key words
	get '/search' do
		h = Hotel.where("name LIKE '%#{ params['words'] }%' OR address LIKE '%#{ params['words'] }%'")

		return [404, {}, "<h1>Not Found</h1>"] if h.blank?
		[200, h.to_json]
	end

	# CREATE a new hotel with the passed params
	post '/hotels' do
		new_hotel = Hotel.new(params)

		return status 501 if !new_hotel.save
		status 201
	end

	# UPDATE an existing hotel with the passed params
	put '/hotels/:id' do
		return [404, {}, "<h1>Not Found</h1>"] if hotel.blank?
		return status 501 if !hotel.update(params.slice('name', 'address', 'star_rating', 'accomodation_type'))
		[200, hotel.to_json]
	end

	# DELETE an existing hotel by ID
	delete '/hotels/:id' do
		return [404, {}, "<h1>Not Found</h1>"] if hotel.blank?
		return status 200 if hotel.destroy
	end


	private

	def hotel
		Hotel.where(id: params['id']).first
	end
end