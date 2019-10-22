class Bill < ApplicationRecord
  BILL_PARAMS = %i(user_id room_id electrical_number status).freeze
  enum status: {paymented: 1, unpayment: 0}

  belongs_to :user
  belongs_to :room
  has_many :bill_services, dependent: :destroy
  has_many :services, through: :bill_services

  delegate :email, to: :user, prefix: true
  delegate :name, to: :user, prefix: true
  delegate :name, to: :room, prefix: true
  delegate :price, to: :room, prefix: true

  scope :ordered_by_created, -> {order created_at: :desc}
  
  validates :electrical_number, presence: true
end
