module ApplicationHelper
  def full_title page_title = ""
    base_title = t "tittle_website"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def get_index_page page = "page", key
    params[page].to_i * Settings.end_stt + key + Settings.start_stt
  end

  def get_index key
    key + Settings.start
  end

  def number_to_vnd number
    number_to_currency(number, unit: "", separator: ",", delimiter: ".", precision: Settings.number_zero) + " " + t("unit")
  end
end
