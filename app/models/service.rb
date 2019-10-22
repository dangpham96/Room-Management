class Service < ApplicationRecord
  SERVICE_PARAMS = %i(name price).freeze

  has_many :bill_services
  has_many :bills, through: :bill_services

  scope :ordered_by_number, -> {order name: :asc}
  scope :not_exits_in_bill, -> id_service{where.not(id: id_service)}

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :price, presence: true
end
