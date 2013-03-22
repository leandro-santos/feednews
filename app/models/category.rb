class Category < ActiveRecord::Base
  extend FriendlyId

  friendly_id :description, use: :slugged

  attr_accessible :description

  validates_presence_of :description
  validates_uniqueness_of :description

  has_many :feed
end