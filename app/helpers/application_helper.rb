module ApplicationHelper

  def current_category(path)
    if request.path.include?(path)
      'selected'
    end
  end

  def current_feed(path)
    if request.path.include?(path)
      'selected'
    end
  end

end
