class ContactController < ApplicationController
  def index
  end

  def mail
    if params[:contact]
      name =  params[:contact][:name]
      email =  params[:contact][:email]
      message = params[:contact][:message]

      if email.present? || message.present?
        # Tell the UserMailer to send a welcome email after save
        ContactMailer.send_contact_email(name, email, message).deliver_now
        flash[:success] = 'Thank you! We will reply within 24 hours!'
        redirect_to '/'
      else
        flash[:warning] = "Please fill out the contact form correctly."
        redirect_to '/'
      end

    end
  end
end
