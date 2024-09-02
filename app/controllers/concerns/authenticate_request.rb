module AuthenticateRequest
  extend ActiveSupport::Concern

  included do
    before_action :authorize_request
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
