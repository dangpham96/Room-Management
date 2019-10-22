class Category < ApplicationRecord
  CATEGORY_PARAMS = %i(name price).freeze
  
  has_many :rooms, dependent: :destroy

  scope :ordered_by_number, -> {order name: :asc}

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :price, presence: true
end
