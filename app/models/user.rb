class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :plan
  
  attr_accessor :stripe_card_token
  # If Pro User passes validations(email , password , etc)
  # Then call stripe to set up a subscription upon charing customers card.
  # Stripe resonds with customer Token
  # Store customer.id as the customer Token and save the User
  def save_with_subscription
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id 
      save!
    end
  end
end
