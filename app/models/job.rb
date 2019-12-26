class Job < ApplicationRecord
  belongs_to :user
  belongs_to :location
  belongs_to :area
  has_many :candidates, dependent: :destroy
  mount_uploader :attachment, AttachmentUploader
end
