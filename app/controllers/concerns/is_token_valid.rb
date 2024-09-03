# frozen_string_literal: true

module IsTokenValid
  extend ActiveSupport::Concern

  included do
    before_action :validate_token
  end

  private

  def validate_token
    header = request.headers['Authorization']
    unless header.present? && header.start_with?('Bearer ')
      render json: { errors: 'Missing or invalid Authorization header' }, status: :unauthorized
      return
    end

    token = header.split(' ').last
    begin
      decoded = JsonWebToken.decode(token)
      @current_recruiter = Recruiter.find(decoded[:recruiter_id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Invalid token' }, status: :unauthorized
    rescue StandardError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
