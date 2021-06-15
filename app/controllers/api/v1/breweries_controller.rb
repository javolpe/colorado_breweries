class Api::V1::BreweriesController < ApplicationController
  def index
    filtered = Brewery.where('name ilike ?', "%#{allowed_filters[:name]}%")
      .where('postal_code ilike ?', "%#{allowed_filters[:postal_code]}%")
      .where('city ilike ?', "%#{allowed_filters[:city]}%")
      .where('brewery_type like ?', "%#{allowed_filters[:brewery_type]}%")
    
    @serial = paginated_response(BrewerySerializer, filtered)
    render json: @serial
  end


  private
  def allowed_filters
    name = params.permit(:name, :postal_code, :city, :brewery_type)
  end
end