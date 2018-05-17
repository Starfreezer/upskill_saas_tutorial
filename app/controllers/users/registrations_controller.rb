class Users::RegistrationsController < Devise::RegistrationsController
  # Extend default devise gem behavior so that users signing up with pro account,
  #(Plan id:2) save with a special Stripe subscription Function
  # Otherwise Devise sets up user as usual.
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end
end