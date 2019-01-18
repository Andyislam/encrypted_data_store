require 'test_helper'

class DataEncryptingKeyTest < ActiveSupport::TestCase
  test ".generate!" do
    assert_difference "DataEncryptingKey.count" do
      key = DataEncryptingKey.generate!
      assert key
    end
  end

  test 'valid key' do
    key = DataEncryptingKey.new(key: 'valid string')
    assert key.valid?
  end


  test 'invalid without key' do
    key = DataEncryptingKey.new(key: nil)
    refute key.valid?
    assert_not_nil key.errors[:key], 'no validation error for key present'
  end

end
