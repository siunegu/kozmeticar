class AdminController < ApplicationController
  before_filter :require_admin!

  def index
  	@reservations_count_today = Reservation.new_reservations_today
  	@count_reservations_canceled = Reservation.reservations_canceled
  	@user_signups = User.last_signups(10)
  	@broadcast_messages = BroadcastMessage.all
  	@broadcast_message = BroadcastMessage.new
  end
end
