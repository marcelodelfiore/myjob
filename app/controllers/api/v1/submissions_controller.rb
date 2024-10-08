# frozen_string_literal: true

class Api::V1::SubmissionsController < ApplicationController

  include IsTokenValid

  before_action :set_submission, only: %i[show update destroy]

  def index
    @submissions = Submission.where(job_id: params[:job_id]).page(params[:page]).per(params[:per_page])
    render json: @submissions
  end

  def show
    render json: @submission
  end

  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      render json: @submission, status: :created
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  def update
    if @submission.update(submission_params)
      render json: @submission
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @submission.destroy
    head :no_content
  end

  private

  def set_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:name, :email, :mobile_phone, :resume, :job_id)
  end
end
