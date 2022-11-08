class User < ActiveRecord::Base
    has_many :projects
    has_many :deliverables, through: :projects
end