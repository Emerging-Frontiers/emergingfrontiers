class Blog < ActiveRecord::Base
  has_many :blog_attachments, :dependent => :destroy
  belongs_to :user
  
end
