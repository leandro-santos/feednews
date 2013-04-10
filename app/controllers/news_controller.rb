class NewsController < ApplicationController

  def recent
    @news = News.paginate(page: params[:page], per_page: 30).order('pub_date DESC NULLS LAST, updated_at DESC').includes(feed: [:category])
  end

  def search
    @news = News.paginate(page: params[:page], per_page: 30).order('pub_date DESC NULLS LAST, updated_at DESC').includes(feed: [:category]).where("LOWER(title) LIKE ?", '%'+params[:value].downcase+'%')
  end

end