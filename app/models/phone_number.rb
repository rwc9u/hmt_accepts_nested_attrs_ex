class PhoneNumber < ActiveRecord::Base
  has_many :phonings, :dependent => :destroy
  has_many :addresses, :through => :phonings, :source => :phonable, :source_type => "Address"
  has_many :people, :through => :phonings, :source => :phonable, :source_type => "Person"
end
