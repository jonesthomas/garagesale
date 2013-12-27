class MessagesController < ApplicationController

  
	def new
		@message = Message.new
  end
  
	def create
    @message = Message.new(message_params)   
    if @message.save

			flash[:success] = "Comment sent! Thank you for your feedback."
       # Tell the UserMailer to send the email after save
       UserMailer.send_comment(@message).deliver
      redirect_to new_message_path
    else
      render 'new'
    end
  end

private
    def message_params
      params.require(:message).permit(:body)
    end
end
