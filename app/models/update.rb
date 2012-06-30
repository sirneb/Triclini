# Model used for the status feed
class Update < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :modifier, :class_name => 'User', :foreign_key => "user_modifier_id"
  
  validates_presence_of :state

  # attr_accessible :reason
end
