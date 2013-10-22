class MessagesController < ApplicationController

  include RecipientHelper

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(:contents => params[:message][:contents])
    unless params[:message][:csv_file]
      flash[:errors] = "Please attach a file containing first names and phone numbers"
      render 'messages/new'
      return
    end
    csv_data = recipients_from_csv(params[:message][:csv_file].tempfile)
    @message.recipients = csv_data[:recipients]
    if csv_data[:errors].any?
      flash[:errors] = "Error extracting data from lines" + csv_data[:errors].join(', ')
    end
    if @message.recipients.empty?
      flash[:errors] = "No recipients in file"
      render 'messages/new'
      return
    end
    if @message.save
      flash[:success] = "Message and data stored to database"
      @message.send_via_sms unless Rails.env.test?
      redirect_to root_url
    else
      flash[:errors] = "Please check the message length and try again"
      render 'messages/new'
    end
  end

end
