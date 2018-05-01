class ContactMailer < ActionMailer::Base
  default to: 'lukas.eisenstecken.bz@gmail.com'
  
  def contact_email(name, email, comments)
    @name = name
    @email = email
    @body = body
    
    mail(from: email, subject: 'Contact Form Message')
  end
end