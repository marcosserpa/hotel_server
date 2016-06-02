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
          accomotaion_type: 'single'
        })

        get '/'

        expect(JSON.parse(last_response.body)).to eql([{ 'id' => 1, 'name' => "Amsterdam Premium Hotel", 'address' => "Marcantilaan St. 134", 'star_rating' => 4, 'accomotaion_type' => 'single' }])
        expect(last_response.status).to eql(200)
      end
    end
  end
end