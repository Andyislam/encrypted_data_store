class RotateWorker
  	include Sidekiq::Worker
  	include Sidekiq::Status::Worker
  	sidekiq_options retry: false, :queue => "rotate_jobs"
    require 'sidekiq/api'


  	def perform(*args)

      
    
	  	# create a new key
  		@new_data_encrypting_key = DataEncryptingKey.generate!(primary: true)
  		# set all old keys primary to false
  		DataEncryptingKey.where.not(id: @new_data_encrypting_key.id).update_all(primary: false)
  		EncryptedString.all.each do |s|
  			decrypted_string = s.value
  			s.update!(data_encrypting_key: @new_data_encrypting_key, value: decrypted_string)
  		end
  		DataEncryptingKey.where.not(id: @new_data_encrypting_key.id).destroy_all

  	end
end
