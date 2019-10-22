class BillService < ApplicationRecord
  after_create_commit :insert_price
  BILL_SERVICE_PARAMS = %i(price bill_id service_id).freeze
  
  belongs_to :bill
  belongs_to :service, optional: true

  delegate :name, to: :service, prefix: true, allow_nil: true
  delegate :price, to: :service, prefix: true, allow_nil: true

  def insert_price
    self.update_attributes price: self.service.price
  end
end
