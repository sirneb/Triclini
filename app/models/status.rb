class Status < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :modifier, :class_name => 'User', :foreign_key => "user_modifier_id"
  
end
