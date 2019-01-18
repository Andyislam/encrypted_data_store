require 'spec_helper'
require 'rails_helper'

RSpec.describe EncryptedString, :type => :model do
	let(:encrypted_string) { EncryptedString.new(value: "test string") }

	describe "validations" do 	    	
  		it { should validate_presence_of(:value).with_message("can't be blank") }
	end

 	describe "associations" do 
  		it { should belong_to(:data_encrypting_key) }
 	end

 	describe "callbacks" do 
 		it { is_expected.to callback(:set_token).before(:validation) }
  		it { is_expected.to callback(:set_data_encrypting_key).before(:validation) }
 	end

  	describe "instance class methods" do
 		context "responds to its methods" do
 			it { expect(encrypted_string).to respond_to(:encode_with_key) }
 		end
 		context "executes correctly" do
	    	context "key_encrypting_key" do
	        	it "should generate string" do
	    			expect(encrypted_string.encode_with_key).to_not be_nil
	        	end
	      	end
	    end
 	end

end