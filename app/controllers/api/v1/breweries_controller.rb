class Api::V1::BreweriesController < ApplicationController
  def index
    filtered = BreweryFacade.filter_breweries(allowed_filters[:filter_name], allowed_filters[:filter_postal_code], allowed_filters[:filter_city], allowed_filters[:filter_brewery_type])
    if filtered.empty?
      render json: { message: "no breweries found matching search criteria" }
    else 
      order_params = make_true_order_params_a_string
      sorted = filtered.order(order_params)
      @serial = paginated_response(BrewerySerializer, sorted)
      render json: @serial
    end
  end

  def make_true_order_params_a_string
    order_params = ""
    allowed_sorting.each do |param|
      order_params += "#{param.first}, "  if param.second == "true"
    end
    order_params = order_params[0..-3]
  end


  private
  def allowed_filters
    name = params.permit(:filter_name, :filter_postal_code, :filter_city, :filter_brewery_type)
  end

  def allowed_sorting
   params.permit(:name, :postal_code, :city, :brewery_type)
  end
end