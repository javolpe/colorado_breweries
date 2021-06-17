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
  describe "Class Methods" do 
    it "should be able to filter breweries by name" do 
      seed_test_db
      expect(Brewery.all.count).to eq(27)
      name = "alpine dog"
      postal_code = nil
      city = nil
      brewery_type = nil
      results = Brewery.filter_brewery_searches(name, postal_code, city, brewery_type)
      
      expect(results.count).to eq(1)
      expect(results.first.name).to eq("Alpine Dog Brewery")
    end
    it "should be able to filter breweries by postal_code" do 
      seed_test_db
      expect(Brewery.all.count).to eq(27)
      name = nil
      postal_code = "8021"
      city = nil
      brewery_type = nil
      results = Brewery.filter_brewery_searches(name, postal_code, city, brewery_type)
      
      expect(results.count).to eq(27)
    end
    it "should not find breweries if no brewery matches" do 
      seed_test_db
      expect(Brewery.all.count).to eq(27)
      name = "?"
      postal_code = nil
      city = nil
      brewery_type = nil
      results = Brewery.filter_brewery_searches(name, postal_code, city, brewery_type)
      
      expect(results.count).to eq(0)
    end
  end
end
