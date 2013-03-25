class FeedsController < ApplicationController

  def index

    @news = News.order('pub_date DESC NULLS LAST, updated_at DESC').limit(20).includes(:feed)
    @categories = Category.includes(:feed)
    @feeds = Feed.where('category_id = ?', 1).order('pub_date DESC NULLS LAST, updated_at DESC').limit(3).includes(:most_recent, :category)

  end

end