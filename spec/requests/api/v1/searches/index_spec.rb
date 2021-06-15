require 'rails_helper'

RSpec.describe "API::V1::Searches::Index", type: :request do 
  before :each do 
    OpenBreweryFacade.seed_db_with_colorado_breweries
  end
  describe "Happy path" do 
    it "can get all breweries, paginated for 20, with no params given" do 
      get '/api/v1/searches'

      expect(response).to be_successful
      body = JSON.parse(response.body, sybolize_names: true)

      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(20)
      expect(body[data.first]).to be_a(Brewery)
      binding.pry
    end
  end
end