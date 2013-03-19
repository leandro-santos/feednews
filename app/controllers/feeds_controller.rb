class FeedsController < ApplicationController

  def index

    @feeds = Feed.order('pub_date DESC NULLS LAST, updated_at DESC').limit(20)

    @feedsWorld = []
    @newsWorld = []
    @categories = []
    @categoryFeeds = []
    Category.all.each do |category|
      @categories << category
      @categoryFeeds << Feed.where('category_id = ?', category.id).limit(6)
      begin
        if category.id == 8
          @categoryFeeds.last.each do |feed|
            if @feedsWorld.size <= 2 && !feed.news.first.title.blank?
              @feedsWorld << feed
              @newsWorld << feed.news.order('pub_date DESC NULLS LAST, created_at DESC').limit(4)
            end
          end
        end
      rescue => error
        p error
      end
    end

  end

end