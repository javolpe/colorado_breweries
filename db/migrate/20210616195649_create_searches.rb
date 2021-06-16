class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :filter_name
      t.string :filter_postal_code
      t.string :filter_city
      t.string :filter_brewery_type
      t.string :name
      t.string :postal_code
      t.string :city
      t.string :brewery_type
      t.integer :counter, :default => 1

      t.timestamps
    end
  end
end
