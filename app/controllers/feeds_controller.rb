class FeedsController < ApplicationController

  def index
    @feedsWorld = []
    @newsWorld = []
    @feeds = []
    Feed.order('pub_date DESC NULLS LAST, updated_at DESC').all().each do |feed|
      @feeds << feed
      begin
        if @feedsWorld.size <= 2
          if !feed.news.first.title.blank? && feed.category_id == 8
            @feedsWorld << feed
            @newsWorld << feed.news.order('pub_date DESC NULLS LAST, created_at DESC').limit(4)
          end
        end
      rescue => error
        p error
      end
    end
  end

end