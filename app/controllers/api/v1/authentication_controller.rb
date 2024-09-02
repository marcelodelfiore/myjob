# frozen_string_literal: true

class Api::V1::AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    recruiter = Recruiter.find_by(email: params[:recruiter][:email])

    if recruiter&.authenticate(params[:recruiter][:password])
      token = JsonWebToken.encode(recruiter_id: recruiter.id)
      render json: { token: token, recruiter: recruiter }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def logout
    head :no_content
  end

  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = JsonWebToken.decode(header)
    @current_recruiter = Recruiter.find(decoded[:recruiter_id])
  rescue ActiveRecord::RecordNotFound, StandardError => e
    render json: { errors: e.message }, status: :unauthorized
  end
end
