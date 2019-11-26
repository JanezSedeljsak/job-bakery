class Post < ApplicationRecord
    belongs_to :user

    validates_presence_of :title, :content
    validates :title, length: { in: 6..20 }

    acts_as_commontable dependent: :destroy
end
