# frozen_string_literal: true

class Recruiter < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
