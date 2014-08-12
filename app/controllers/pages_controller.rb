class PagesController < ApplicationController

  def home
  end

  def recent_reservations
    @recent_reservations = Reservation.joins(:product).recent.order("available_at DESC")
  end
end