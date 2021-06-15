class Brewery < ApplicationRecord
  validates :db_id, uniqueness: true
  validates :obdb_id, uniqueness: true 

  validates :db_id, presence: { require: true }
  validates :obdb_id, presence: { require: true }
  validates :name, presence: { require: true }
  validates :brewery_type, presence: { require: true }
  validates :city, presence: { require: true }
  validates :state, presence: { require: true }
  validates :postal_code, presence: { require: true }
end
