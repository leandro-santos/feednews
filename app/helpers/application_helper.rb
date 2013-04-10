module ApplicationHelper

  def title(title)
    content_for :title, title
  end

  def current_category(path)
    if request.path.include?(path)
      'selected'
    end
  end

  def current_feed(path)
    if request.path == path || request.path.to(path.size) == path+'/'
      'selected'
    end
  end

end
