class ReservationJob < ApplicationJob
	queue_as :default

	def perform(reservation)

		ReservationMailer.reservation_email(reservation.user.email, reservation.listing.user.email, reservation.id).deliver_later

    	# Do something later
	end
end
