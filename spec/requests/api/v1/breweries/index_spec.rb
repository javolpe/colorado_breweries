require 'rails_helper'

RSpec.describe "API::V1::Breweries::Index", type: :request do 
  before :each do 
    Brewery.destroy_all
    seed_test_db
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
    it "can get all breweries, paginated for 10" do 
      get '/api/v1/breweries?per_page=10'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(10)
    end
    it "can get breweries 6-10 if paginated properly" do 
      get '/api/v1/breweries?per_page=5&page=2'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].first[:attributes][:name]).to eq("Our Mutual Friend")
      expect(body[:data].count).to eq(5)
    end
    it "can get all breweries with color in name" do 
      get '/api/v1/breweries?filter_name=color'
      
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(2)
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
    it "can get all breweries in city of denver paginated for 7" do 
      get '/api/v1/breweries?filter_city=denver&per_page=7'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(7)
      expect(body[:data].all?{|brewery| brewery[:attributes][:city].downcase.include? "denver"}).to eq(true)
    end
    it "can get all large breweries" do 
      get '/api/v1/breweries?filter_brewery_type=large'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(9)
      expect(body[:data].all?{|brewery| brewery[:attributes][:brewery_type] == 'large'}).to eq(true)
    end
    it "can get all micro breweries in denver" do 
      get '/api/v1/breweries?filter_brewery_type=micro&filter_city=denver'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(18)
      expect(body[:data].all?{|brewery| brewery[:attributes][:brewery_type] == 'micro'}).to eq(true)
      expect(body[:data].all?{|brewery| brewery[:attributes][:city].downcase.include? "denver"}).to eq(true)
    end
    it "can get all micro breweries in denver with brew in their name" do 
      get '/api/v1/breweries?filter_brewery_type=micro&filter_city=denver&filter_name=brew'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(12)
      expect(body[:data].all?{|brewery| brewery[:attributes][:brewery_type] == 'micro'}).to eq(true)
      expect(body[:data].all?{|brewery| brewery[:attributes][:city].downcase.include? "denver"}).to eq(true)
      expect(body[:data].all?{|brewery| brewery[:attributes][:name].downcase.include? "brew"}).to eq(true)
    end
    it "can get all micro breweries in denver sorted by postal_code" do 
      get '/api/v1/breweries?filter_brewery_type=micro&filter_city=denver&sort_postal_code=true'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(18)
      expect(body[:data].all?{|brewery| brewery[:attributes][:brewery_type] == 'micro'}).to eq(true)
      expect(body[:data].all?{|brewery| brewery[:attributes][:city].downcase.include? "denver"}).to eq(true)
      expect(body[:data].first[:attributes][:postal_code].to_i <  body[:data][10][:attributes][:postal_code].to_i).to eq(true)
    end
    it "can get all breweries in denver sorted by postal_code and brewery_type" do
      #  if two breweries are in the same postal_code they should be sorted by brewery_type
      get '/api/v1/breweries?filter_city=denver&sort_postal_code=true&sort_brewery_type=true'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(20)
      expect(body[:data].all?{|brewery| brewery[:attributes][:city].downcase.include? "denver"}).to eq(true)
      expect(body[:data].first[:attributes][:postal_code] ==  body[:data].second[:attributes][:postal_code]).to eq(true)
      expect(body[:data].first[:attributes][:brewery_type] <  body[:data].second[:attributes][:brewery_type]).to eq(true)
    end
    it "can get all breweries with postal code 8021 and sort by postal_code" do
      #  finds all breweries with 8021 in zip and then sort by zip
      get '/api/v1/breweries?filter_postal_code=8021&sort_postal_code=true'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(20)
      expect(body[:data].all?{|brewery| brewery[:attributes][:postal_code].include? "8021"}).to eq(true)
      expect(body[:data].first[:attributes][:postal_code].to_i < body[:data][10][:attributes][:postal_code].to_i).to eq(true)
    end
  end
  describe "Sad Path" do 
    it "wont find any breweries if name doesnt match anything" do 
      get '/api/v1/breweries?filter_name=colorado is the best place I love it'
      
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      
      expect(body[:message]).to eq("no breweries found matching search criteria")
    end
    it "wont find any breweries if zip is not real" do 
      get '/api/v1/breweries?filter_postal_code=805987'
      
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      
      expect(body[:message]).to eq("no breweries found matching search criteria")
    end
    it "wont find any breweries if city is not real" do 
      get '/api/v1/breweries?filter_city=not a real city'
      
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      
      expect(body[:message]).to eq("no breweries found matching search criteria")
    end
    it "wont find any breweries if brewery_type is not real" do 
      get '/api/v1/breweries?filter_brewery_type=imaginary'
      
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      
      expect(body[:message]).to eq("no breweries found matching search criteria")
    end
    it "wont find any breweries if given nonsesne" do 
      get '/api/v1/breweries?filter_brewery_type=?'
      
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      
      expect(body[:message]).to eq("no breweries found matching search criteria")
    end
    it "does default pagination if given bad page params" do 
      get '/api/v1/breweries?page=cat'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(20)
    end
    it "does default pagination if given bad per_page params" do 
      get '/api/v1/breweries?per_page=?!@!'

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      check_hash_structure(body, :data, Array)
      expect(body[:data].count).to eq(20)
    end
  end
end