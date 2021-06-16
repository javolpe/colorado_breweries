require 'rails_helper'

RSpec.describe "API::V1::Breweries::Index", type: :request do 
  before :each do 
    OpenBreweryFacade.seed_db_with_colorado_breweries
  end
  describe "Happy path" do 
    it "can get all breweries, paginated for 20, with no params given" do 
      get '/api/v1/breweries'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(20)
    end
    it "can get all breweries with color in name" do 
      get '/api/v1/breweries?filter_name=color'
      
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(8)
      expect(body[:data].all?{|brewery| brewery[:attributes][:name].downcase.include? "color"}).to eq(true)
    end
    it "can get all breweries with 802 in the postal_code" do 
      get '/api/v1/breweries?filter_postal_code=802'
      
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(20)
      expect(body[:data].all?{|brewery| brewery[:attributes][:postal_code].downcase.include? "802"}).to eq(true)
    end
    it "can get all breweries in city of denver" do 
      get '/api/v1/breweries?filter_city=denver'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(20)
      expect(body[:data].all?{|brewery| brewery[:attributes][:city].downcase.include? "denver"}).to eq(true)
    end
    it "can get all large breweries" do 
      get '/api/v1/breweries?filter_brewery_type=large'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(7)
      expect(body[:data].all?{|brewery| brewery[:attributes][:brewery_type] == 'large'}).to eq(true)
    end
    it "can get all micro breweries in denver" do 
      get '/api/v1/breweries?filter_brewery_type=micro&filter_city=denver'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(20)
      expect(body[:data].all?{|brewery| brewery[:attributes][:brewery_type] == 'micro'}).to eq(true)
      expect(body[:data].all?{|brewery| brewery[:attributes][:city].downcase.include? "denver"}).to eq(true)
    end
    it "can get all micro breweries in denver with brew in their name" do 
      get '/api/v1/breweries?filter_brewery_type=micro&filter_city=denver&filter_name=brew'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(20)
      expect(body[:data].all?{|brewery| brewery[:attributes][:brewery_type] == 'micro'}).to eq(true)
      expect(body[:data].all?{|brewery| brewery[:attributes][:city].downcase.include? "denver"}).to eq(true)
      expect(body[:data].all?{|brewery| brewery[:attributes][:name].downcase.include? "brew"}).to eq(true)
    end
    it "can get all micro breweries in denver sorted by postal_code" do 
      get '/api/v1/breweries?filter_brewery_type=micro&filter_city=denver&postal_code=true'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(20)
      expect(body[:data].all?{|brewery| brewery[:attributes][:brewery_type] == 'micro'}).to eq(true)
      expect(body[:data].all?{|brewery| brewery[:attributes][:city].downcase.include? "denver"}).to eq(true)
      expect(body[:data].first[:attributes][:postal_code].to_i <  body[:data].third[:attributes][:postal_code].to_i).to eq(true)
    end
    it "can get all breweries in denver sorted by postal_code and brewery_type" do
      #  if two breweries are in the same postal_code they should be sorted by brewery_type
      get '/api/v1/breweries?filter_city=denver&postal_code=true&name=true&brewery_type=true'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(20)
      expect(body[:data].all?{|brewery| brewery[:attributes][:city].downcase.include? "denver"}).to eq(true)
      expect(body[:data].first[:attributes][:postal_code] ==  body[:data].second[:attributes][:postal_code]).to eq(true)
      expect(body[:data].first[:attributes][:brewery_type] <  body[:data].second[:attributes][:brewery_type]).to eq(true)
    end
  end
end