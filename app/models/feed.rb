class Feed < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title, use: :slugged

  attr_accessible :rss_Link,
                  :xml_version,
                  :rss_version,
                  :title,
                  :link,
                  :description,
                  :language,
                  :copyright,
                  :managing_editor,
                  :web_master,
                  :pub_date,
                  :last_build_date,
                  :categories,
                  :category_domain,
                  :generator,
                  :docs,
                  :cloud_domain,
                  :cloud_port,
                  :cloud_path,
                  :cloud_register_procedure,
                  :cloud_protocol,
                  :ttl,
                  :image_url,
                  :image_title,
                  :image_link,
                  :image_width,
                  :image_height,
                  :rating,
                  :text_input_title,
                  :text_input_description,
                  :text_input_name,
                  :text_input_link,
                  :skip_hours_hour,
                  :skip_days_day

  #validates_presence_of :link
  validates_presence_of :title
  #validates_format_of :link, with: /^(https?:\/\/)?(www\.)?([a-zA-Z0-9_\-]+)+\.([a-zA-Z]{2,4})/
  validates_uniqueness_of :rss_link
  #validates_uniqueness_of :title

  has_many :news, dependent: :destroy
  belongs_to :category

end