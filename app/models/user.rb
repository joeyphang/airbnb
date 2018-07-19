class User < ApplicationRecord
  include Clearance::User
  has_many :listings, dependent: :destroy
  has_many :reservations, dependent: :destroy

  enum role: {Customer: 0, Moderator: 1, Admin: 2}

  mount_uploader :avatar, AvatarUploader

end
