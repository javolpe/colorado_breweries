class SearchFacade 
  def self.create_unique_searches(filters, sorters)
    search_params = {filter_name: filters[:filter_name],
                     filter_postal_code: filters[:filter_postal_code],
                     filter_city: filters[:filter_city],
                     filter_brewery_type: filters[:filter_brewery_type],
                     name: sorters[:name],
                     postal_code: sorters[:postal_code],
                     city: sorters[:city],
                     brewery_type: sorters[:brewery_type]
                    }

    if search_record = Search.find_by(search_params)
      search_record.counter += 1
      search_record.save
    else  
      Search.create(search_params)
    end
  end
end