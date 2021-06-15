require 'rails_helper' 

RSpec.describe OpenBreweryFacade, type: :model do 
  describe 'class methods' do 
    it "should hit service and return 432 records when query = colorado", :vcr do
      response = OpenBreweryFacade.one_query_search("colorado")
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

    it "should seed the db with all the Colorado breweries availalbe" do 
      Brewery.destroy_all
      expect(Brewery.all.count).to eq(0)
      OpenBreweryFacade.seed_db_with_colorado_breweries
      expect(Brewery.all.count).to be > 425
      
      co_breweries = Brewery.order(:state)
      
      expect(co_breweries.all?{|brewery| brewery.state == "Colorado"}).to eq(true)
      
    end
  end
end