class Project < ActiveRecord::Base
  attr_accessible :name, :slug

  has_many :developer_projects
  has_many :developers, :through => :developer_projects
  has_many :achievements
  
  acts_as_url :name, url_attribute: :slug
end
