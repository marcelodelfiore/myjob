class Job < ApplicationRecord
  belongs_to :recruiter

  validates :title, presence: true
  validates :description, presence: true
  validates :recruiter_id, presence: true
end
