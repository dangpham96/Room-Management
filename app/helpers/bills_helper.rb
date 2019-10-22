module BillsHelper
  def get_money_electric bill
    bill.electrical_number * Settings.electric_money    
  end
  
  def get_monney_service bill
    bill.bill_services.sum :price
  end

  def sum_money_bill  bill
    bill.electrical_number * Settings.electric_money + bill.room_price + (bill.bill_services.sum :price)
  end
end
