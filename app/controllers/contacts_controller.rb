class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
       redirect_to new_contact_path, notice: "Message sent."
    else
       redirect_to new_contact_path, notice: "An Error has occured , please try again later."
    end
  end
  
  private
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
end