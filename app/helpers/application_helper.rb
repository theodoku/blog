module ApplicationHelper
  def bootstrap_class_for(flash_key)
    case flash_key
    when 'success'
      'success'
    when 'alert'
      'danger'
    else
      'info'
    end
  end
end
