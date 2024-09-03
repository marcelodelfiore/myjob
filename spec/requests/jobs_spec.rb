# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Jobs", type: :request do
  let!(:recruiter) { create(:recruiter) }
  let!(:job) { create(:job, recruiter: recruiter) }

  describe "GET /jobs/:id" do
    it "returns the job" do
      get job_path(job)
      expect(response).to have_http_status(:ok)
      expect(json['id']).to eq(job.id)
    end
  end

  describe "POST /jobs" do
    let(:valid_attributes) do
      {
        job: {
          title: "Software Developer",
          description: "Develops software.",
          start_date: Date.today,
          end_date: Date.today + 30,
          status: "open",
          skills: "Ruby, Rails",
          recruiter_id: recruiter.id
        }
      }
    end

    it "creates a new job" do
      expect {
        post jobs_path, params: valid_attributes
      }.to change(Job, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH /jobs/:id" do
    let(:new_attributes) do
      {
        job: {
          title: "Updated Job Title"
        }
      }
    end

    it "updates the job" do
      patch job_path(job), params: new_attributes
      job.reload
      expect(job.title).to eq("Updated Job Title")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /jobs/:id" do
    it "deletes the job" do
      expect {
        delete job_path(job)
      }.to change(Job, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
