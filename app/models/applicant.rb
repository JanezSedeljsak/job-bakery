class Applicant < ApplicationRecord
  belongs_to :User
  belongs_to :Job
end
