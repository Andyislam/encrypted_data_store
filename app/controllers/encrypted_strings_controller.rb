class EncryptedStringsController < ApplicationController

  before_action :load_encrypted_string, only: [:show, :destroy]


  # temp added to allow testing through postman or other 3rd party addons
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def create
    @encrypted_string = EncryptedString.new(value: encrypted_string_params[:value])
    if @encrypted_string.save
      render json: { token: @encrypted_string.token }
    else
      render json: { message: @encrypted_string.errors.full_messages.to_sentence},
             status: :unprocessable_entity
    end
  end

  def show
    render json: { value: @encrypted_string.value }
  end

  def destroy
    @encrypted_string = EncryptedString.find_by(token: params[:token])
    if @encrypted_string.nil?
      render json: { message: "No entry found}" },
             status: :not_found
    else
      @encrypted_string.destroy!
      render json: { message: "Token successfully deleted" }
    end
  end

  private

  def load_encrypted_string
    @encrypted_string = EncryptedString.find_by(token: params[:token])
    if @encrypted_string.nil?
      render json: { message: "No entry found for token #{params[:token]}" },
             status: :not_found
    end
  end

  def encrypted_string_params
    params.require(:encrypted_string).permit(:value)
  end
end
