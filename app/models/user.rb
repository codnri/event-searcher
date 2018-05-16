class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events         
  has_many :attends
  
  def stripe_customer(source_id)
    if stripe_id?
      stripe_customer = Stripe::Customer.retrieve(stripe_id)

      if stripe_customer.sources.empty? && source_id.present?
        stripe_customer.sources.create({:source => source_id})
      end
      stripe_customer
    else
      stripe_customer = Stripe::Customer.create(email: email, source: source_id)
      update(stripe_id: stripe_customer.id) # save the returned stripe_customer.id to the User record
      stripe_customer
    end
  end
  
  def has_attended?(event_id)
    attend = self.attends.where(event_id: event_id).first
  end
  
  def is_event_owner?(event_id)
    self.id == (Event.find(event_id).user_id||0)
  end
  
end
