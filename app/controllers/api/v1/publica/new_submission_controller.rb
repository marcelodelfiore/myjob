# frozen_string_literal: true

class Api::V1::Publica::NewSubmissionController < ApplicationController

  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      render json: @submission, status: :created
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  private

  def set_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:name, :email, :mobile_phone, :resume, :job_id)
  end
end
