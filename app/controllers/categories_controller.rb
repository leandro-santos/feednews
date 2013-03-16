class CategoriesController < ApplicationController

  def show
    @feeds = []
    @news = []
    @category = Category.find_by_slug(params[:id])
    Feed.order('pub_date DESC NULLS LAST, updated_at DESC').find_all_by_category_id(@category.id).each do |i|
      @feeds << i
      @news << @feeds.last.news.order('pub_date DESC NULLS LAST, updated_at DESC').limit(6)
    end
  end

  def item
    @feeds = []
    @feed = Feed.find(params[:feed])
    @news = @feed.news.order('pub_date DESC NULLS LAST, updated_at ASC')
    category_id = Category.find_by_slug(params[:id]).id
    Feed.order('pub_date DESC NULLS LAST, updated_at DESC').find_all_by_category_id(category_id).each do |i|
      @feeds << i
    end
  end

end