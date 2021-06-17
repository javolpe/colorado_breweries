require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:filter_name).scoped_to( :filter_postal_code, :filter_city, :filter_brewery_type, :sort_name, :sort_postal_code, :sort_city, :sort_brewery_type) }
  end

end
