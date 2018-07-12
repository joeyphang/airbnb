class User < ApplicationRecord
  include Clearance::User
  has_many :listings, dependent: :destroy
  has_many :reservations, dependent: :destroy

  enum role: {customer: 0, moderator: 1, admin: 2}

  mount_uploader :avatar, AvatarUploader

end
