class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing

	validate :check_dates
    validates_presence_of :start_date, :end_date
    validate :end_date_is_after_start_date
    validate :overlapping_reservations

    # Checks if the booking start date is in the past
   def check_dates
       if start_date.present? && start_date < Date.today
           errors.add(:check_in_date, message:"Unavailable")
       end
   end

   def end_date_is_after_start_date
       return if end_date.blank? || start_date.blank?

       if end_date < start_date
       errors.add(:end_date, "Choose a date after start date!")
       end
   end

   # Check if a given reservation overlaps this interval
   def overlapping_reservations
       
       Reservation.where("listing_id =?", self.listing_id).each do |r|
           if overlaps?(r)
               return errors.add(:overlapping_dates, message:"These dates are unavailable.")
           end
       end
   end

   private    
	   # Checks if a given reservation overlaps this reservation    
	   def overlaps?(other)
	       self.start_date <= other.end_date && other.start_date <= self.end_date
	   end

	# validate :check_overlapping_dates

	# before_save :calculate_price

	## check if a given interval overlaps this interval

	# def check_overlapping_dates
	# 	Reservation.all.each do |r|

	# 		return false if self.overlaps?(r)
	# 	end
	# 	return true
	# end

	# def calculate_price
	# 	self.total_price = self.listing.price * (self.start.to_start - self.end.to_date).to_i
	# 	p "hello"
		
	# end

end