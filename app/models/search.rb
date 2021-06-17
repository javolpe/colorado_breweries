class Search < ApplicationRecord
  validates :filter_name, uniqueness: { scope: [:filter_postal_code, :filter_city, :filter_brewery_type, :sort_name, :sort_postal_code, :sort_city, :sort_brewery_type] }
end
