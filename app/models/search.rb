class Search < ApplicationRecord
  validates :filter_name, uniqueness: { scope: [:filter_postal_code, :filter_city, :filter_brewery_type, :name, :postal_code, :city, :brewery_type] }
end
