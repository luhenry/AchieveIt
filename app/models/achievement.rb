class Achievement < ActiveRecord::Base
  attr_accessible :id, :image, :name, :slug, :project_id
end
