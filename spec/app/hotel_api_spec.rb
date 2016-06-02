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
end