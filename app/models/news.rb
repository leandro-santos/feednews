class News < ActiveRecord::Base

  attr_accessible :title,
                  :description,
                  :link,
                  :author,
                  :category_domain,
                  :comments,
                  :enclosure_url,
                  :enclosure_length,
                  :enclosure_type,
                  :guid_is_perma_link,
                  :pub_date,
                  :source_url

  belongs_to :feed

  #validates_presence_of :link
  #validates_format_of :link, with: /^(https?:\/\/)?(www\.)?([a-zA-Z0-9_\-]+)+\.([a-zA-Z]{2,4})/

end