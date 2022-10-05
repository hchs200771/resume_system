class Candidate < ApplicationRecord
  has_many :resumes
  has_many :work_experiences
end
