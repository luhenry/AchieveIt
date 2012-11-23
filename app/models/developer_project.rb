class DeveloperProject < ActiveRecord::Base
  attr_accessible :developer_id, :project_id

  belongs_to :developer
  belongs_to :project
end
