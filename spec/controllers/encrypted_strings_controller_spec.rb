require 'spec_helper'
require 'rails_helper'

RSpec.describe EncryptedStringsController, :type => :controller do
	
	before :all do
        @encrypted_string = EncryptedString.create!(value: "decrypted string")
  	end




  	describe "POST create" do
  		
  		context "with valid attributes" do
		    it "creates a new encrypted string" do
	     	 	expect{post(:create, params: { encrypted_string: { value: "to encrypt" }})}.to change(EncryptedString,:count).by(1)
		    end
		    it "has a 200 status code" do
		      	post(:create, params: { encrypted_string: { value: "to encrypt" }})
		      	expect(response.status).to eq(200)
		    end
		    it "sends back a token" do 
		    	post(:create, params: { encrypted_string: { value: "to encrypt" }})
		    	json = JSON.parse(response.body)
		    	expect(json['token']).to_not be_nil
		    end
	  	end

	  	context "with invalid attributes" do
	  		it "does not create a new encrypted string" do
		    	expect{post(:create, params: { encrypted_string: { value: nil }})}.to change(EncryptedString,:count).by(0)
	  		end
	  		it "has a 422 status code" do
		      	post(:create, params: { encrypted_string: { value: nil }})
      			expect(response.status).to eq(422)
		    end
		    it "returns a blank value message" do
		      	post(:create, params: { encrypted_string: { value: nil }})
		      	json = JSON.parse(response.body)
		    	expect(json['message']).to eq("Value can't be blank")
		   	end
	  	end
  	end


  	describe "GET show" do

		context "with valid token" do
			it "returns 'decrypted string'" do 
				get(:show, params: {token: @encrypted_string.token})
		      	json = JSON.parse(response.body)
				expect(json['value']).to eq("decrypted string")
			end
			it "has a 200 status code" do
		      	get(:show, params: {token: @encrypted_string.token})
		      	expect(response.status).to eq(200)
		    end

		end

		context "with invalid token" do
			it "returns does not exist" do 
				get(:show, params: {token: "invalid_token"})
		      	json = JSON.parse(response.body)
				expect(json['message']).to eq("No entry found for token invalid_token")
			end 
			it "has a 404 status code" do 
				get(:show, params: {token: "invalid_token"})
				expect(response.status).to eq(404)
			end

		end
  	end

  	describe "PUT delete" do 
  		context "with valid token" do 
  			it "deletes a the record" do 
  				temp_token = EncryptedString.create!(value: "decrypted string")
  				expect{post(:destroy, params: { token:  temp_token.token})}.to change(EncryptedString,:count).by(-1)
  			end
  			it "has a 200 status code" do
  				temp_token = EncryptedString.create!(value: "decrypted string")
		      	post(:destroy, params: { token:  temp_token.token})
		      	expect(response.status).to eq(200)
		    end 

		    it "returns 'Token successfully deleted'" do
  				temp_token = EncryptedString.create!(value: "decrypted string")
		      	post(:destroy, params: { token:  temp_token.token})
		      	json = JSON.parse(response.body)
				expect(json['message']).to eq("Token successfully deleted")
		    end 
  		end


  		context "with invalid token" do 
  			it "deletes a the record" do 
  				expect{post(:destroy, params: { token:  "invalid_token"})}.to change(EncryptedString,:count).by(0)
  			end
  			it "has a 404 status code" do
		      	post(:destroy, params: { token:  "invalid_token"})
		      	expect(response.status).to eq(404)
		    end 
		    it "returns 'Token successfully deleted'" do
		      	post(:destroy, params: { token:  "invalid_token"})
		      	json = JSON.parse(response.body)
				expect(json['message']).to eq("No entry found for token invalid_token")
		    end 
  		end

  		
  	end
  

end