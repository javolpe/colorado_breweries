class Api::V1::BreweriesController < ApplicationController
  def index
    SearchFacade.create_unique_searches(allowed_filters, allowed_sorting)
    filtered = BreweryFacade.filter_breweries(allowed_filters[:filter_name], allowed_filters[:filter_postal_code], allowed_filters[:filter_city], allowed_filters[:filter_brewery_type])
    if filtered.empty?
      render json: { message: "no breweries found matching search criteria" }
    else 
      sorted = BreweryFacade.sort_filtered_breweries(filtered, allowed_sorting)
      @serial = paginated_response(BrewerySerializer, sorted)
      render json: @serial
    end
  end


  private
  def allowed_filters
    name = params.permit(:filter_name, :filter_postal_code, :filter_city, :filter_brewery_type)
  end

  def allowed_sorting
   params.permit(:sort_name, :sort_postal_code, :sort_city, :sort_brewery_type)
  end
end