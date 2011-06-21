class Phoning < ActiveRecord::Base
  belongs_to :phone_number, :autosave => true
  belongs_to :phonable, :polymorphic => true

  accepts_nested_attributes_for :phone_number

  # for testing and demo purposes this added dynamically in the
  # address tests.
 # def autosave_associated_records_for_phone_number
 #    if new_phone_number = PhoneNumber.where(:phone_number =>  phone_number.phone_number).first then
 #      self.phone_number = new_phone_number
 #    else
 #      self.phone_number.save!
 #      self.phone_number_id = self.phone_number.id
 #    end
 # end

end
