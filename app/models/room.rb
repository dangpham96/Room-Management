class Room < ApplicationRecord
  ROOM_PARAMS = %i(name category_id status payment).freeze
  enum status: {active: 1, unactive: 0}
  enum payment: {paymented: 1, unpayment: 0}
  after_create :update_price

  belongs_to :category
  has_many :user, dependent: :nullify
  has_many :bill

  scope :ordered_by_id, -> {order(id: :asc)}
  scope :find_by_status_room, -> status {where(status: status)}

  delegate :name, to: :category, prefix: true
  delegate :price, to: :category, prefix: true
  delegate :name, to: :user, prefix: true

  validates :name, presence: true

  def update_price
    update price: self.category.price
  end
end
