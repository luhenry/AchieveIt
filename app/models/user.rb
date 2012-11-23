class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :id, :last_name

  has_many :achievements, :through => :user_achievements
end
