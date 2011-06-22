require 'test_helper'

class AddressTest < ActiveSupport::TestCase

  def setup
    @original_phone_number_count = PhoneNumber.count
  end

  test "An address can be created with valid parameters" do
    a = Address.new(default_address)
    a.save
    assert_equal "Cville", Address.find(a.id).city
  end

  test "An address can be created with nested phone attributes" do
    a = Address.new(default_address(
                                    "phonings_attributes"=>
                                    {"1289233155995"=>
                                      {"phone_number_attributes"=>
                                        {"phone_number"=>"17032221234"},
                                        "_destroy"=>"false"}
                                    }
                                    ))
    a.save!
    assert_equal "Cville", Address.find(a.id).city
    assert_equal "17032221234", Address.find(a.id).phone_numbers.first.phone_number
    assert_equal 3, PhoneNumber.count
  end

  test "By default adding the same phone number will create a new phone number row when adding a second phone number" do
    a = Address.new(default_address(
                                    "phonings_attributes"=>
                                    {"1289233155995"=>
                                      {"phone_number_attributes"=>
                                        {"phone_number"=>"17032221234"},
                                        "_destroy"=>"false"}
                                    }
                                    ))
    a.save!
    assert_equal "Cville", Address.find(a.id).city
    assert_equal "17032221234", Address.find(a.id).phone_numbers.first.phone_number
    b = Address.new(default_address(:address1 => "234 Test",
                                    "phonings_attributes"=>
                                    {"1289233155995"=>
                                      {"phone_number_attributes"=>
                                        {"phone_number"=>"17032221234"},
                                        "_destroy"=>"false"}
                                    }
                                    ))
    b.save!
    assert_equal "Cville", Address.find(b.id).city
    assert_equal "17032221234", Address.find(b.id).phone_numbers.first.phone_number
    assert_equal @original_phone_number_count + 2, PhoneNumber.count
    assert_equal 2, PhoneNumber.where(:phone_number => "17032221234").count
  end

  test "When you override the autosave associated for the join table then you can point multiple addresses at the same phone number object." do

    # overriding autosave_associated_records_for_phone_numbers
    Phoning.send :define_method, :autosave_associated_records_for_phone_number do
      if new_phone_number = PhoneNumber.where(:phone_number =>  phone_number.phone_number).first then
           self.phone_number = new_phone_number
      else
        self.phone_number.save!
        self.phone_number_id = self.phone_number.id
      end
    end

    a = Address.new(default_address(
                                    "phonings_attributes"=>
                                    {"1289233155995"=>
                                      {"phone_number_attributes"=>
                                        {"phone_number"=>"17032221234"},
                                        "_destroy"=>"false"}
                                    }
                                    ))
    a.save!
    assert_equal "Cville", Address.find(a.id).city
    assert_equal "17032221234", Address.find(a.id).phone_numbers.first.phone_number
    b = Address.new(default_address(:address1 => "234 Test",
                                    "phonings_attributes"=>
                                    {"1289233155995"=>
                                      {"phone_number_attributes"=>
                                        {"phone_number"=>"17032221234"},
                                        "_destroy"=>"false"}
                                    }
                                    ))
    b.save!
    assert_equal "Cville", Address.find(b.id).city
    assert_equal "17032221234", Address.find(b.id).phone_numbers.first.phone_number
    assert_equal @original_phone_number_count + 1, PhoneNumber.count
    assert_equal 1, PhoneNumber.where(:phone_number => "17032221234").count
  end


end
