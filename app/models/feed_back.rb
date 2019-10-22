class FeedBack < ApplicationRecord
  FEEDBACK_PARAM = %i(title detail status user_id).freeze
  enum status: {active: 1, unactive: 0}

  belongs_to :user

  scope :ordered_by_created, -> {order(created_at: :desc)}

  validates :detail, presence: true, length: { maximum: 140 }

  delegate :name, to: :user, prefix: true

  scope :find_by_title_fb, -> title{where(" title like ?", "%#{title}%" )}
end
