require 'spec_helper'

RSpec.describe App do
  def app
    App
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