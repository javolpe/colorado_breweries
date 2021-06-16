FactoryBot.define do
  factory :search do
    filter_name { "MyString" }
    filter_postal_code { "MyString" }
    filter_city { "MyString" }
    filter_brewery_type { "MyString" }
    name { "MyString" }
    postal_code { "MyString" }
    city { "MyString" }
    brewery_type { "MyString" }
    counter { 1 }
  end
end
