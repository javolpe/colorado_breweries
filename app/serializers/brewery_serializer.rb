class BrewerySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :brewery_type, :street, :address_2, :address_3, :city, :state, :county_province, :postal_code, :phone, :website_url
end
