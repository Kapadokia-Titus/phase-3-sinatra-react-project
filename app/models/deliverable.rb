class Deliverable < ActiveRecord::Base
    belongs_to :project
    has_many :users
end