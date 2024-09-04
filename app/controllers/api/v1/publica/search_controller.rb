class Api::V1::Publica::SearchController < ApplicationController
  def index
    jobs = Job.all

    jobs = jobs.where('title ILIKE ?', "%#{params[:title]}%") if params[:title].present?
    jobs = jobs.where('description ILIKE ?', "%#{params[:description]}%") if params[:description].present?
    jobs = jobs.where('skills ILIKE ?', "%#{params[:skills]}%") if params[:skills].present?

    paginated_jobs = jobs.page(params[:page]).per(params[:per_page])

    render json: paginated_jobs, status: :ok
  end
end
