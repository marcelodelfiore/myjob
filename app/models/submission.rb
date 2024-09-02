class Submission < ApplicationRecord
  belongs_to :job

  validates :email, uniqueness: true
end
