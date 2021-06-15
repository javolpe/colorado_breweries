require 'rails_helper'

RSpec.describe Brewery, type: :model do
  describe 'validations' do 
    it { should validate_uniqueness_of :db_id }
    it { should validate_uniqueness_of :obdb_id }

    it { should validate_presence_of :db_id }
    it { should validate_presence_of :obdb_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :brewery_type }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :postal_code }
  end

  
end
