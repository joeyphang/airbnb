class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservation

  	mount_uploader :avatar, AvatarUploader

	# scope :country_search, -> (country_search) { where "country ILIKE ?", country_search}
	scope :country, -> (country) { where country: country }
    scope :title, -> (title) { where("title ilike ?", "#{type}")}
    scope :num_of_guest, -> (num_of_guest) { where num_of_guest: num_of_guest }
    scope :num_of_bedroom, -> (num_of_bedroom) { where num_of_bedroom: num_of_bedroom }
    scope :price_range, -> (from,to) {where ("price >= ? AND price <= ?"), from, to}
end