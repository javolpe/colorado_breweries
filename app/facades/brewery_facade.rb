class BreweryFacade 
  def self.filter_breweries(name, postal_code, city, brewery_type)
    Brewery.filter_brewery_searches(name, postal_code, city, brewery_type)
  end

end