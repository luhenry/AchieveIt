class Project < ActiveRecord::Base
  attr_accessible :id, :name, :slug

  has_many :developers, :through => :developer_projects
  has_many :achievements
end
