# frozen_string_literal: true

class Api::V1::Publica::JobDetailController < ApplicationController
  before_action :set_job, only: %i[show]

  def show
    render json: @job
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:id)
  end
end
