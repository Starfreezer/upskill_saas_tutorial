class ContactsController < ApplicationController
  
  # GET request to /contact-us
  # Shot new contact form
  def new
    @contact = Contact.new
  end
  
  #POST request /contacts
  def create
    # Mass asignment of form fields to Contact objects
    @contact = Contact.new(contact_params)
    # save the Contact object to the database
    if @contact.save
      # Store form fields via parameters into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # plug variables into the Contact Mailer
      # email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      # Store success message in flash hash
      # and redirect to the new action
      flash[:success] = "Message sent."
       redirect_to new_contact_path
    else
      # if Contact object doesn't save store errors in flash hash
      # and redirect to new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  
  private
  # to collect data from forms , use strong parameters
  #and white-list form fields
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
end