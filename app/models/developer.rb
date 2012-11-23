class Developer < ActiveRecord::Base
  attr_accessible :email, :first_name, :id, :last_name, :password_hash

  has_many :projects, :through => :developer_projects
end
