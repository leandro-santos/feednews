class Feed < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title, use: :slugged

  attr_accessible :rssLink,
                  :xml_version,
                  :rss_version,
                  :title,
                  :link,
                  :description,
                  :language,
                  :copyright,
                  :managingEditor,
                  :webMaster,
                  :pubDate,
                  :lastBuildDate,
                  :categories,
                  :categoryDomain,
                  :generator,
                  :docs,
                  :cloudDomain,
                  :cloudPort,
                  :cloudPath,
                  :cloudRegisterProcedure,
                  :cloudProtocol,
                  :ttl,
                  :imageUrl,
                  :imageTitle,
                  :imageLink,
                  :imageWidth,
                  :imageHeight,
                  :rating,
                  :textInputTitle,
                  :textInputDescription,
                  :textInputName,
                  :textInputLink,
                  :skipHoursHour,
                  :skipDaysDay

  validates_presence_of :link
  validates_presence_of :title
  #validates_format_of :link, with: /^(https?:\/\/)?(www\.)?([a-zA-Z0-9_\-]+)+\.([a-zA-Z]{2,4})/
  validates_uniqueness_of :rssLink
  validates_uniqueness_of :title

  has_many :news, dependent: :destroy
  belongs_to :category

end