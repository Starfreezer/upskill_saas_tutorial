class ProfilesController < ApplicationController
  #Get to /users/:user_id/profile/new
  def new
    # Render Blank Profile details Form
    @profile = Profile.new
  end
  
  #POST to /users/:user_id/profile
  def create
    #Ensure that we have the user that is filling out the Form
    @user = User.find( params[:user_id] )
    # Create profile linked to this specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      flash[:danger] = "An Error has occured , please try again"
      render action: :new
    end
  end
  
  private 
    def profile_params
      params.require(:profile).permit( :first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
    end
end
