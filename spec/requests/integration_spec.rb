require 'spec_helper'
require 'rails_helper'
require 'sidekiq/api'
require 'sidekiq/testing'
Sidekiq::Testing.disable! 



describe "Integration test" do  

	before :all do 
		# "clear out old data" 
		EncryptedString.all.destroy_all
		DataEncryptingKey.all.destroy_all
		
		# "create DataEncryptingKey" 
		@key = DataEncryptingKey.generate!(primary: true)
		
		# "create 1500 dummy records" 
		(1..100).each do |i|
			EncryptedString.create!(value: "Test string #{i}")
		end
	end


	describe "Check if all sample data has been created" do
		it "should increment DataEncryptingKey records to 1" do 
			expect(DataEncryptingKey.all.count).to eq(1)
		end

		it "should increment DataEncryptingKey records to 1500" do 
			expect(EncryptedString.all.count).to eq(100)
		end
	end


	describe "begin rotate job" do
		before :each do 
			RotateWorker.clear
			post "/api/v1/data_encrypting_keys/rotate"
		end
		it "has a 201 status code" do 
			expect(response.status).to eq(201)
		end
		it "has a success message" do 		
			json = JSON.parse(response.body)
    		expect(json['message']).to eq("Key rotation has been queued")
		end

		context "poll status until" do 
			it "returns No key rotation queued or in progress" do 
				get "/api/v1/data_encrypting_keys/rotate/status"
		  		json = JSON.parse(response.body)
				begin
					puts "Rotate Job is in progress, retrying in 5 seconds"
				  	sleep(5.seconds)
				end while json['message'] != "No key rotation queued or in progress"
				get "/api/v1/data_encrypting_keys/rotate/status"
				json = JSON.parse(response.body)
    			expect(json['message']).to eq("No key rotation queued or in progress")
			end
		end
	end


end