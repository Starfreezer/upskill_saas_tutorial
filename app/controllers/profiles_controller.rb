class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
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
      redirect_to user_path( id: params[:user_id])
    else
      flash[:danger] = "An Error has occured , please try again"
      render action: :new
    end
  end
  
  #Get /users/user_id/profile/edit
  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
    
  end
  
  #Put/patch to /users/:user_id/profile
  def update
    #Retrieve the User from the Database
    @user = User.find( params[:user_id])
    #Retrieve that Users Profile
    @profile = @user.profile
    #Mass assign params
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated!"
      #redirect user to their profile page
      redirect_to user_path(id: params[:user_id])
    else
      render action: :edit
      flash[:danger] = "An error occured please try again."
    end
    
    
  end
  
  private 
    def profile_params
      params.require(:profile).permit( :first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description,)
    end
    
    def only_current_user
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless @user == current_user
    end
end
