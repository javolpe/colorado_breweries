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

  def self.filter_brewery_searches(name, postal_code, city, brewery_type)
    Brewery.where('name ilike ?', "%#{name}%")
    .where('postal_code ilike ?', "%#{postal_code}%")
    .where('city ilike ?', "%#{city}%")
    .where('brewery_type like ?', "%#{brewery_type}%")
  end

end
