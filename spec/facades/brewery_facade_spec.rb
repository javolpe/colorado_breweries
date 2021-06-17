require 'rails_helper'

RSpec.describe "Brewery Facade", type: :model do 
  describe "Class Methods" do 
     it "can format the sorting params as needed" do 
      allowed_sorting={sort_name: "true", sort_postal_code: "true", sort_city: "true" }
      result = BreweryFacade.make_true_order_params_a_string(allowed_sorting)
      
      expect(result).to eq("name, postal_code, city")
    end
    it "returns empty string if no params given" do 
      allowed_sorting={ }
      result = BreweryFacade.make_true_order_params_a_string(allowed_sorting)
      
      expect(result).to eq("")
    end
  end
end