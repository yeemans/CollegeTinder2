class MessagesController < ApplicationController
  def create
    @current_user = current_user
    @message = @current_user.messages.create(content: msg_params[:content], room_id: params[:room_id])
    respond_to do |format|
      format.turbo_stream
      format.html{ redirect_to message_path(params[:message][:id])}
    end
  end

  private

  def msg_params
    params.require(:message).permit(:content)
  end
end