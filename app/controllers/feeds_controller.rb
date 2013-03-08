class FeedsController < ApplicationController

  def index
    @feeds = []
    @news = []
    Feed.where('category_id = ?', 8).order('pub_date DESC, updated_at DESC').each do |i|
      @feeds << i
      @news << @feeds.last.news.order('pub_date DESC, created_at DESC').limit(6)
    end
  end

end