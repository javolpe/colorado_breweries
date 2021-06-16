require 'rails_helper'

RSpec.describe "Search Facade", type: :model do 
  describe "Class Methods" do 
    it "should create a new search record if unique, increase counter by one if not unique" do 
      filters = {filter_name: "color",
                      filter_postal_code: nil,
                      filter_city: "denver",
                      filter_brewery_type: nil}

      sorters = {name: nil,
                postal_code: nil,
                city: nil,
                brewery_type: "true"
                }


      Search.destroy_all
      SearchFacade.create_unique_searches(filters, sorters)
      expect(Search.all.count).to eq(1)

      SearchFacade.create_unique_searches(filters, sorters)
      expect(Search.all.count).to eq(1)
      expect(Search.first.counter).to eq(2)
    end
    it "same test different attributes" do 
      filters = {filter_name: nil,
                 filter_postal_code: "802",
                 filter_city: "denver",
                 filter_brewery_type: nil}

      sorters = {name: nil,
                postal_code: nil,
                city: nil,
                brewery_type: "true"}

      Search.destroy_all
      SearchFacade.create_unique_searches(filters, sorters)
      expect(Search.all.count).to eq(1)

      SearchFacade.create_unique_searches(filters, sorters)
      expect(Search.all.count).to eq(1)
      expect(Search.first.counter).to eq(2)
    end
  end
end