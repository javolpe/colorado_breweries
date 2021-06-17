class BreweryFacade 
  def self.filter_breweries(name, postal_code, city, brewery_type)
    Brewery.filter_brewery_searches(name, postal_code, city, brewery_type)
  end

  def self.sort_filtered_breweries(filtered, allowed_sorting)
    order_params = BreweryFacade.make_true_order_params_a_string(allowed_sorting)
    filtered.order(order_params)
  end

  def self.make_true_order_params_a_string(allowed_sorting)
    order_params = ""
    allowed_sorting.each do |param|
      order_params += "#{param.first[5..-1]}, "  if param.second == "true"
    end
    order_params = order_params[0..-3]
  end

end