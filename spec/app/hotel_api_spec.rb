require 'spec_helper'

RSpec.describe HotelApi do
  def app
    HotelApi
  end

  describe "GET hotels" do
    context "when there is no hotels" do
      it "returns none" do
        get '/'

        expect(last_response.body).to eql('[]')
        expect(last_response.status).to eql(200)
      end
    end

    context "when there is one hotel" do
      it "returns that hotel" do
        Hotel.create({
          name: "Amsterdam Premium Hotel",
          address: "Marcantilaan St. 134",
          star_rating: 4,
          accomodation_type: 'single'
        })

        get '/'

        expect(JSON.parse(last_response.body)).to eql([{ 'id' => 1, 'name' => "Amsterdam Premium Hotel", 'address' => "Marcantilaan St. 134", 'star_rating' => 4, 'accomodation_type' => 'single' }])
        expect(last_response.status).to eql(200)
      end
    end

    context "when there is more than one hotel" do
      it "returns all the hotels" do
        Hotel.create({
          name: "Amsterdam Premium Hotel",
          address: "Marcantilaan St. 134",
          star_rating: 4,
          accomodation_type: 'single'
        })
        Hotel.create({
          name: "Rotterdam Hotel",
          address: "Bergweg St. 302",
          star_rating: 5,
          accomodation_type: 'single'
        })

        get '/'

        expect(JSON.parse(last_response.body)).to eql([{ 'id' => 1, 'name' => "Amsterdam Premium Hotel", 'address' => "Marcantilaan St. 134", 'star_rating' => 4, 'accomodation_type' => 'single' }, { 'id' => 2, 'name' => "Rotterdam Hotel", 'address' => "Bergweg St. 302", 'star_rating' => 5, 'accomodation_type' => 'single' }])
        expect(last_response.status).to eql(200)
      end
    end
  end

  describe "GET a specific hotel" do
    context "when the hotel is not found" do
      it "returns a message" do
        get '/hotels/1', {}, { 'Accept' => 'application/json' }

        expect(last_response.body).to eql("<h1>Not Found</h1>")
        expect(last_response.status).to eql(404)
      end
    end

    context "when the hotel is found" do
      it "returns that hotel" do
        Hotel.create({
          name: "Amsterdam Premium Hotel",
          address: "Marcantilaan St. 134",
          star_rating: 4,
          accomodation_type: 'single'
        })

        get '/hotels/1', {}, { 'Accept' => 'application/json' }

        expect(JSON.parse(last_response.body)).to eql({ 'id' => 1, 'name' => "Amsterdam Premium Hotel", 'address' => "Marcantilaan St. 134", 'star_rating' => 4, 'accomodation_type' => 'single' })
        expect(last_response.status).to eql(200)
      end
    end
  end

  describe "POST a new hotel" do
    context "when trying to create new hotel and" do
      it "there is no hotels yet, returns" do
        expect(Hotel.all.count).to be_zero
      end

      it "creates the hotel, returns success" do
        hotel_params = {
          name: "Rotterdam Hotel",
          address: "Bergweg St. 302",
          star_rating: 5,
          accomodation_type: 'single'
        }

        post '/hotels', hotel_params, { 'Accept' => 'application/json' }

        hotel = Hotel.all.first

        expect(Hotel.all.count).to eql(1)
        expect(hotel.name).to eql("Rotterdam Hotel")
        expect(last_response.body).to eql('')
        expect(last_response.status).to eql(201)
      end
    end
  end

  describe "PUT a hotel" do
    context "when trying to update a hotel but it's not found" do
      it "returns not found" do
        hotel_params = {
          name: "Rotterdam Hotel",
          address: "Bergweg St. 302",
          star_rating: 5,
          accomodation_type: 'single'
        }

        put '/hotels/1', hotel_params, { 'Accept' => 'application/json' }

        expect(last_response.body).to eql("<h1>Not Found</h1>")
        expect(last_response.status).to eql(404)
      end
    end

    context "when trying to update an existent hotel" do
      it "must update and return the updated hotel" do
        Hotel.create({
          name: "Amsterdam Premium Hotel",
          address: "Marcantilaan St. 134",
          star_rating: 4,
          accomodation_type: 'single'
        })

        hotel_params = {
          name: "New Amsterdam Premium Hotel",
          star_rating: 3
        }

        put '/hotels/1', hotel_params, { 'Accept' => 'application/json' }

        expect(JSON.parse(last_response.body)).to eql({ 'id' => 1, 'name' => "New Amsterdam Premium Hotel", 'address' => "Marcantilaan St. 134", 'star_rating' => 3, 'accomodation_type' => 'single' })
        expect(last_response.status).to eql(200)
        expect(Hotel.all.count).to eql(1)
      end
    end
  end

  describe "DELETE a hotel" do
    context "when trying to delete a hotel but it's not found" do
      it "returns not found" do
        delete '/hotels/1', { 'Accept' => 'application/json' }

        expect(last_response.body).to eql('<h1>Not Found</h1>')
        expect(last_response.status).to eql(404)
      end
    end

    context "when trying to delete an existing hotel" do
      it "must delete and return success" do
        hotel = Hotel.create({
          name: "Amsterdam Premium Hotel",
        })

        expect(Hotel.all.count).to eql(1)
        expect(hotel.name).to eql("Amsterdam Premium Hotel")

        delete '/hotels/1', { 'Accept' => 'application/json' }

        expect(Hotel.all.count).to be_zero
        expect(last_response.status).to eql(200)
      end
    end
  end

  describe "Search for a hotel" do
    context "when the hotel is not found" do
      it "returns none" do
        get '/search', { words: 'Amsterdam' }, { 'Accept' => 'application/json' }

        expect(last_response.body).to eql("<h1>Not Found</h1>")
        expect(last_response.status).to eql(404)
      end
    end

    context "when a hotel is found" do
      it "returns that hotel" do
        Hotel.create({
          name: "Amsterdam Premium Hotel",
          address: "Marcantilaan St. 134",
          star_rating: 4,
          accomodation_type: 'single'
        })

        get '/search', { words: 'Amsterdam' }, { 'Accept' => 'application/json' }

        expect(JSON.parse(last_response.body)).to eql([{ 'id' => 1, 'name' => "Amsterdam Premium Hotel", 'address' => "Marcantilaan St. 134", 'star_rating' => 4, 'accomodation_type' => 'single' }])
        expect(last_response.status).to eql(200)
      end
    end

    context "when more than one hotel is found" do
      it "returns all that hotels" do
        Hotel.create({
          name: "Amsterdam Premium Hotel",
          address: "Marcantilaan St. 134",
          star_rating: 4,
          accomodation_type: 'single'
        })
        Hotel.create({
          name: "Amsterdam Hotel",
          address: "Marcantilaan St. 134",
          star_rating: 5,
          accomodation_type: 'single'
        })

        get '/search', { words: 'Amsterdam' }, { 'Accept' => 'application/json' }

        expect(JSON.parse(last_response.body)).to eql([{ 'id' => 1, 'name' => "Amsterdam Premium Hotel", 'address' => "Marcantilaan St. 134", 'star_rating' => 4, 'accomodation_type' => 'single' }, { 'id' => 2, 'name' => "Amsterdam Hotel", 'address' => "Marcantilaan St. 134", 'star_rating' => 5, 'accomodation_type' => 'single' }])
        expect(last_response.status).to eql(200)
      end
    end
  end
end