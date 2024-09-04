# frozen_string_literal: true

class Api::V1::Publica::ActiveJobsController < ApplicationController

  def index
    @jobs = Job.where(status: 'active').page(params[:page]).per(params[:per_page])
    render json: @jobs
  end
end
