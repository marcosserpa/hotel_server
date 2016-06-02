require 'spec_helper'

RSpec.describe HotelApi do
  def app
    HotelApi
  end

  describe "Test" do
    context "blah" do
      it "home" do
        get '/hi'

        expect(last_response.body).to eql("Hello World!")
      end
    end
  end
end