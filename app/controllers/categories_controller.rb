class CategoriesController < ApplicationController

  def show
    @feeds = []
    @category = Category.includes(:feed).find_by_slug(params[:id])
    @feeds = @category.feed.order('pub_date DESC NULLS LAST, updated_at DESC').includes(:news)
  end

  def item
    @feed = Feed.find(params[:feed])
    @news = @feed.news.order('pub_date DESC NULLS LAST, updated_at ASC')
    #@news = @feed.news.paginate(:page => params[:page], :per_page => 4).order('pub_date DESC NULLS LAST, updated_at ASC')
    @category = Category.includes(:feed).find_by_slug(params[:id])
  end

  #def item
  #  @feeds = []
  #  @feed = Feed.find(params[:feed])
  #  @news = @feed.news.paginate(:page => params[:page], :per_page => 4).order('pub_date DESC NULLS LAST, updated_at ASC')
  #  category_id = Category.find_by_slug(params[:id]).id
  #  Feed.order('pub_date DESC NULLS LAST, updated_at DESC').includes(:category).find_all_by_category_id(category_id).each do |i|
  #    @feeds << i
  #  end
  #end

end