class ContactMailer < ApplicationMailer
  default from: 'info@syd-explorer.com.au'

  def send_contact_email(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(to: 'shouhei.yamauchi@live.com', subject: 'Visitor message from SYD Explorer') do |format|
      format.html { render 'contact_mailer' }
      format.text { render 'contact_mailer' }
    end
  end
end
