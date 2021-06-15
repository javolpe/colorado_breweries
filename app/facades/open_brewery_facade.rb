class OpenBreweryFacade
  def self.one_query_search(term)
    response = OpenBreweryService.one_query_search(term)
  end

  def self.seed_db_with_colorado_breweries 
    response = OpenBreweryFacade.one_query_search("colorado")
    breweries = JSON.parse(response.body, symbolize_names: true)
    co_breweries = breweries.select{|brewery| brewery[:state].downcase == "colorado"}
    
    co_breweries.each do |brewery|
      Brewery.create!(
        db_id: brewery[:id],
        obdb_id: brewery[:obdb_id],
        name: brewery[:name],
        brewery_type: brewery[:brewery_type],
        street: brewery[:street],
        address_2: brewery[:address_2],
        address_3: brewery[:address_3],
        city: brewery[:city],
        state: brewery[:state],
        county_province: brewery[:county_province],
        postal_code: brewery[:postal_code][0..4],
        country: brewery[:country],
        longitude: brewery[:longitude],
        latitude: brewery[:latitude],
        phone: brewery[:phone],
        website_url: brewery[:website_url]
      )
    end
  end
end