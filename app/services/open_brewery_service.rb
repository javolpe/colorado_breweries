class OpenBreweryService 
  def self.conn 
    connection = Faraday.new(url: "https://api.openbrewerydb.org")
  end

  def self.one_query_search(search_term)
    response = conn.get("/breweries/search") do |req|
      req.params['query'] = search_term
    end
  end
end