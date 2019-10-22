module UsersHelper
  def get_room
    params[:action] == Settings.edit_action ? Room.pluck(:name, :id) : Room.unactive.pluck(:name, :id)     
  end 
end
