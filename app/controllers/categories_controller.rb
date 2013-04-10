class CategoriesController < ApplicationController

  def show
    @feeds = []
    @category = Category.includes(:feed).find_by_slug(params[:id])
    @feeds = @category.feed.paginate(page: params[:page], per_page: 6).order('pub_date DESC NULLS LAST, updated_at DESC').includes(:most_recent)
  end

  def item
    @feed = Feed.find_by_slug(params[:feed])
    @news = @feed.news.paginate(page: params[:page], per_page: 25).order('pub_date DESC NULLS LAST, updated_at ASC')
    @category = Category.includes(:feed).find_by_slug(params[:id])
  end

  def detail
    @feed = Feed.find_by_slug(params[:feed])
    @news = @feed.news.paginate(page: params[:page], per_page: 25).order('pub_date DESC NULLS LAST, updated_at ASC')
    @category = Category.includes(:feed).find_by_slug(params[:id])
    @selectedNews = News.find_by_slug(params[:news])
  end

end