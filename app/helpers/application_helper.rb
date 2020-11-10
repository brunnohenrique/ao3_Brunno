module ApplicationHelper
  def color_type_message(message_type)
    message_type == 'alert' ? 'warning' : 'primary'
  end
end
