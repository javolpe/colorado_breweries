require 'rails_helper'

RSpec.describe "Search Facade", type: :model do 
  describe "Class Methods" do 
    it "should create a new search record if unique, increase counter by one if not unique" do 
      filters = {filter_name: "color",
                 filter_postal_code: nil,
                 filter_city: "DENver",
                 filter_brewery_type: nil}

      sorters = {name: nil,
                postal_code: nil,
                city: nil,
                brewery_type: "true"}


      Search.destroy_all
      SearchFacade.create_unique_searches(filters, sorters)
      expect(Search.all.count).to eq(1)
      expect(Search.first.filter_city).to eq("denver")

      SearchFacade.create_unique_searches(filters, sorters)
      expect(Search.all.count).to eq(1)
      expect(Search.first.filter_city).to eq("denver")
      expect(Search.first.counter).to eq(2)
    end
    it "same test different attributes" do 
      filters = {filter_name: nil,
                 filter_postal_code: "802",
                 filter_city: "DENver",
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
    it "saves a search with no attributes" do 
      filters = {filter_name: nil,
                 filter_postal_code: nil,
                 filter_city: nil,
                 filter_brewery_type: nil}

      sorters = {name: nil,
                postal_code: nil,
                city: nil,
                brewery_type: nil}

      Search.destroy_all
      SearchFacade.create_unique_searches(filters, sorters)
      expect(Search.all.count).to eq(1)

      SearchFacade.create_unique_searches(filters, sorters)
      expect(Search.all.count).to eq(1)
      expect(Search.first.counter).to eq(2)
    end
    it "saves two searches if different data" do 
      filters = {filter_name: nil,
              filter_postal_code: "802",
              filter_city: "DENver",
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