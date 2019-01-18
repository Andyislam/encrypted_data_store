require 'spec_helper'
require 'rails_helper'
require 'sidekiq/api'
require 'sidekiq/testing'
Sidekiq::Testing.fake! 

RSpec.describe Api::V1::KeyRotationController , :type => :request do  

	describe "POST rotate" do
		
	  	context "when no active rotate jobs running" do 

			before :each do 
				RotateWorker.clear
			end
	  	
	  		it "has a 201 status code" do 
	  			post "/api/v1/data_encrypting_keys/rotate"
	  			expect(response.status).to eq(201)
	  		end

	  		it "has a success message" do 
	  			post "/api/v1/data_encrypting_keys/rotate"
	  			json = JSON.parse(response.body)
		    	expect(json['message']).to eq("Key rotation has been queued")
	  		end


	  	end
		
		context "when job is already in progress" do 
			before :each do
				RotateWorker.clear
		        post "/api/v1/data_encrypting_keys/rotate"     
		  	end 
	  		it "has a 200 status code" do 
		        post "/api/v1/data_encrypting_keys/rotate"
	  			expect(response.status).to eq(200)
	  		end

	  		it "has a in progress message" do 
		        post "/api/v1/data_encrypting_keys/rotate"
	  			json = JSON.parse(response.body)
		    	expect(json['message']).to eq("Key rotation is in progress")
	  		end
	  	end
		
	end



	describe "GET current_status" do

		context "when no active rotate jobs running" do 

			before :each do 
				RotateWorker.clear
			end
	  	
	  		it "has a 201 status code" do 
	  			get "/api/v1/data_encrypting_keys/rotate/status"
	  			expect(response.status).to eq(200)
	  		end

	  		it "has a success message" do 
	  			get "/api/v1/data_encrypting_keys/rotate/status"
	  			json = JSON.parse(response.body)
		    	expect(json['message']).to eq("No key rotation queued or in progress")
	  		end


	  	end
		
		context "when job is already in progress" do 
			before :each do
				RotateWorker.clear
		        post "/api/v1/data_encrypting_keys/rotate"
		  	end 
	  		it "has a 200 status code" do 
		        get "/api/v1/data_encrypting_keys/rotate/status"
	  			expect(response.status).to eq(200)
	  		end

	  		it "has a in progress message" do 
		        get "/api/v1/data_encrypting_keys/rotate/status"
	  			json = JSON.parse(response.body)
		    	expect(json['message']).to eq("Key rotation is in progress")
	  		end
	  	end

	end
end