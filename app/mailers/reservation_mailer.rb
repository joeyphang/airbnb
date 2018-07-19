class ReservationMailer < ApplicationMailer
	def reservation_email(customer, host, reservation_id)
		@customer = customer
		@host = host
		@reservation_id = reservation_id
		@url = 'http://localhost:3000/reservations/:id'
		mail(to: 'testmailer090@gmail.com', subject: 'mailer-test')

	end
end
