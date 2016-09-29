class User < ActiveRecord::Base
  validates :first_name,                            presence: true
  validates :last_name,                             presence: true
  validates :email,                                 presence: true
  validates :social_security_number,                presence: true
  validates_length_of :social_security_number,      is: 9
  validates_format_of :social_security_number,      with: /\A\d+\z/
  validates_format_of :email,                       with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
