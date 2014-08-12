class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :cancel]


  def index
    @reservations = current_user.reservations.includes(:user, :product).normal
  end

  def show
  end

  def new
    @product = Product.where('name = ?', params[:product_id]).first if params[:product_id].present?
    @reservation = Reservation.new product: @product
  end
 
  def create
    @reservation = current_user.reservations.create reservation_params

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'You can cancel your reservation max. 30 mins prior to the beginning of the reservation.' }
        format.json { render action: 'show', status: :created, location: @reservation }
      else
        format.html { render action: 'new' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    @reservation.cancel

    redirect_to '/reservations'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:starts_at, :user_id, :product_id, :is_canceled)
    end
end
