class Course < ActiveRecord::Base
    belongs_to :user
    # validates :name, :schedule, :notes, presence: true
end
