class BroadcastMessagesController < ApplicationController
  before_filter :require_admin!

  def create
    @broadcast_message = BroadcastMessage.create(broadcast_message_params)

    redirect_to '/admin'
  end

  def destroy
    @broadcast_message = BroadcastMessage.find(params[:id])
    
    @broadcast_message.destroy
    respond_to do |format|
      format.html { redirect_to '/admin' }
    end
  end

  private
  
    def broadcast_message_params
      params.require(:broadcast_message).permit(:message)
    end
end
