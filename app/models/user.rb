class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :id, :last_name
end
