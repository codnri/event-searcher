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
    attends = self.attends
    attends.find { |a| a.event_id == event_id }
  end
  
end
