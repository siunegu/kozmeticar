class PagesController < ApplicationController

  def home
  end

  def recent_reservations
    @recent_reservations = Reservation.joins(:product).order("available_at DESC").all
  end

  def recent_visits
  	@recent_visits = Visit.order("started_at DESC").all
  	@recent_visits = Visit.search_visits(params[:search]) unless params[:search].blank?
  end
end