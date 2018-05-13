class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events         
  has_many :attends
  
  def stripe_customer(source_id)
    if stripe_id?
      Stripe::Customer.retrieve(stripe_id)
    else
      stripe_customer = Stripe::Customer.create(email: email, source: source_id)
      update(stripe_id: stripe_customer.id) # save the returned stripe_customer.id to the User record
      stripe_customer
    end
  end
  
  def has_attended?(event_id)
    attend = self.attends.where(event_id: event_id).first
  end
  
  # # allow users to update their accounts without passwords
  # def update_without_current_password(params, *options)
  #   p "*******^----------***********"
  #   p params.inspect
  #   params.delete(:current_password)
 
  #   if params[:password].blank? && params[:password_confirmation].blank?
  #     params.delete(:password)
  #     params.delete(:password_confirmation)
  #   end
 
  #   result = update_attributes(params, *options)
  #   clean_up_passwords
  #   result
  # end
  
end
