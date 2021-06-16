require 'rails_helper'

RSpec.describe OpenBreweryService, type: :service do 
  describe 'happy path' do 
    it "should return 432 records when query = colorado", :vcr do
      response = OpenBreweryService.one_query_search("colorado")
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body.count).to eq(432)
      expect(body.first.keys.count).to eq(18)
      expect(body).to be_an(Array)
      check_hash_structure(body.first, :id, Integer)
      check_hash_structure(body.first, :obdb_id, String)
      check_hash_structure(body.first, :name, String)
      check_hash_structure(body.first, :brewery_type, String)
      check_hash_structure(body.first, :street, String)
      check_hash_structure(body.first, :city, String)
      check_hash_structure(body.first, :state, String)
      check_hash_structure(body.first, :postal_code, String)
      check_hash_structure(body.first, :country, String)
    end
  end
  describe 'sad path' do 
    it "should not find anything if given nonsense query param", :vcr do 
      response = OpenBreweryService.one_query_search("colorado is my favorite state")
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to be_an(Array)
      expect(body).to be_empty
    end
  end
end 