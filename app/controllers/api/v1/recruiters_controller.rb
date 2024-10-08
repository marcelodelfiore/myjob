# frozen_string_literal: true

class Api::V1::RecruitersController < ApplicationController

  include IsTokenValid

  before_action :set_recruiter, only: %i[show update destroy]

  def index
    @recruiters = Recruiter.page(params[:page]).per(params[:per_page])
    render json: @recruiters
  end

  def show
    render json: @recruiter
  end

  def create
    @recruiter = Recruiter.new(recruiter_params)

    if @recruiter.save
      render json: @recruiter, status: :created
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end

  def update
    @recruiter = Recruiter.find(params[:id])

    if @recruiter.update(recruiter_params)
      render json: @recruiter
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @recruiter.destroy
    head :no_content
  end

  private

  def set_recruiter
    @recruiter = Recruiter.find(params[:id])
  end

  def recruiter_params
    params.require(:recruiter).permit(:name, :email, :password, :password_confirmation)
  end
end
