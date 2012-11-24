class Achievement < ActiveRecord::Base
  attr_accessible :image, :name, :project_id, :slug

  has_many :achievement_steps
  has_many :users, :through => :user_achievements

  belongs_to :project

  acts_as_url :name, url_attribute: :slug
end
