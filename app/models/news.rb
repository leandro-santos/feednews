class News < ActiveRecord::Base

  attr_accessible :title,
                  :description,
                  :link,
                  :author,
                  :categoryDomain,
                  :comments,
                  :enclosureUrl,
                  :enclosureLength,
                  :enclosureType,
                  :guidIsPermaLink,
                  :pubDate,
                  :sourceUrl

  belongs_to :feed

  #validates_presence_of :link
  #validates_format_of :link, with: /^(https?:\/\/)?(www\.)?([a-zA-Z0-9_\-]+)+\.([a-zA-Z]{2,4})/

end