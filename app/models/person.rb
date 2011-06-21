class Person < ActiveRecord::Base

  has_many :phonings, :as => :phonable
  has_many :phone_numbers, :through => :phonings
end
