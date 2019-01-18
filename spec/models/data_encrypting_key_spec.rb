require 'spec_helper'

RSpec.describe DataEncryptingKey, :type => :model do

	let(:encription_key) { DataEncryptingKey.generate!(primary: true) }

  	describe "validations" do 
  		it { should validate_presence_of(:key).with_message("can't be blank") }
	end

 	describe "public class methods" do
 		context "responds to its methods" do
	      it { expect(DataEncryptingKey).to respond_to(:primary) }
	      it { expect(DataEncryptingKey).to respond_to(:generate!) }
	    end

	  	context "executes correctly" do

	      	context "self.generate!" do
	        	it "should generate new key" do
	    			expect { DataEncryptingKey.generate!(primary: true)}.to change{ DataEncryptingKey.count }.by(1)
	        	end
	      	end

	      	context "self.primary" do 
	      		it "should return true" do
	    			expect(encription_key.primary).to be true
	      		end
	      	end

     	 	
	    end
 
 	end

 	describe "public instance methods" do

 		context "responds to its methods" do
	      	it { expect(encription_key).to respond_to(:key_encrypting_key) }
	    end

	    context "executes correctly" do
	    	context "key_encrypting_key" do
	        	it "should generate string" do
	    			expect(encription_key.key_encrypting_key).to_not be_nil
	        	end
	      	end
	    end
 	end

end