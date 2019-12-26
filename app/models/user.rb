class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :candidates, dependent: :destroy

  mount_uploader :avatar, AttachmentUploader
  mount_uploader :biography, BiographyUploader

  acts_as_commontator
end
