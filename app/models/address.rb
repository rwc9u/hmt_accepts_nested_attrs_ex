class Address < ActiveRecord::Base
  has_many :phonings, :as => :phonable
  has_many :phone_numbers, :through => :phonings

  accepts_nested_attributes_for :phonings, :allow_destroy => true

end
