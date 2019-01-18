module Api

	require 'sidekiq/api'
	
	module V1

		class ApplicationController < ActionController::API
		  include ActionController::MimeResponds
		end


		class KeyRotationController < ApplicationController
			def rotate
  				response = response_msg(1)
  				if should_cue?	
					RotateWorker.perform_async
  				end
				render json: response, status: response[:status]
			end

			def current_status
  				response =  response_msg(2)
  				render json: response, status: response[:status]
			end

			private

			def response_msg(called_from)
				if !should_cue?
					{message: "Key rotation is in progress", status: :ok}
				else
					case called_from
					when 1
						{message: "Key rotation has been queued", status: :created}
					when 2
						{message: "No key rotation queued or in progress", status: :ok}
					end	
				end
			end

			def should_cue?
				if key_rotate_workers > 0
					false
				else
					true
				end
			end

			def key_rotate_workers

				if Rails.env == "test"
					# this was added to account for the rspec tests. in test env,the jobs are added to this array as opped to the workers array
					return RotateWorker.jobs.size
				else
					workers = Sidekiq::Workers.new
					return workers.size
				end
				
			end
		end
	end
end