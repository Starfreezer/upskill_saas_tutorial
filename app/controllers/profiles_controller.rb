class ProfilesController < ApplicationController
  #Get to /users/:user_id/profile/new
  def new
    # Render Blank Profile details Form
    @profile = Profile.new
  end
end
