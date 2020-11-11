class User < ActiveRecord::Base
    has_secure_password
    has_many :courses
    # has_many :assignments, through: :courses
    has_many :assignments, :through => :courses

    # accepts_nested_attributes_for :courses
    def slug
        self.username.gsub(" ", "-").downcase
    end
    
    def self.find_by_slug(slug)
        self.all.find{|user| user.slug == slug}
    end
end
