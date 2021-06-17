class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :filter_name
      t.string :filter_postal_code
      t.string :filter_city
      t.string :filter_brewery_type
      t.string :sort_name
      t.string :sort_postal_code
      t.string :sort_city
      t.string :sort_brewery_type
      t.integer :counter, :default => 1

      t.timestamps
    end
  end
end
