class SearchFacade 
  def self.create_unique_searches(filters, sorters)
    search_params = {filter_name: filters[:filter_name],
                     filter_postal_code: filters[:filter_postal_code],
                     filter_city: filters[:filter_city],
                     filter_brewery_type: filters[:filter_brewery_type],
                     sort_name: sorters[:sort_name],
                     sort_postal_code: sorters[:sort_postal_code],
                     sort_city: sorters[:sort_city],
                     sort_brewery_type: sorters[:sort_brewery_type]
                    }
      
      downcase_params = {} 
      search_params.each do |key, value|
        downcase_params[key] = value.downcase if value.present?
      end
      
    if search_record = Search.find_by(downcase_params)
      search_record.counter += 1
      search_record.save
    else  
      Search.create(downcase_params)
    end
  end
end