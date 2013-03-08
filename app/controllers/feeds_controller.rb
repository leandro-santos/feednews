class FeedsController < ApplicationController

  def index
    @feeds = []
    @news = []
    Feed.where('category_id = ?', 8).order('pubDate DESC, updated_at DESC').each do |i|
      @feeds << i
      @news << @feeds.last.news.order('pubDate DESC, created_at DESC').limit(6)
    end
  end

end