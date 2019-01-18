require 'test_helper'

class EncryptedStringTest < ActiveSupport::TestCase

  def setup
    @data_encrypting_key = DataEncryptingKey.generate!(primary: true)
  end

  test 'valid string' do
  	string = EncryptedString.new(value: 'valid string')
    assert string.valid?
  end

  test 'invalid without value' do
  	string = EncryptedString.new(value: nil)
    refute string.valid?
    assert_not_nil string.errors[:value], 'no validation error for value present'
  end

  test 'invalid without data_encrypting_key' do
  	
  end

  test 'invalid without token' do
  end



end
