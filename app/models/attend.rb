class Attend < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :event_id, presence: true
  validates :user_id, presence: true
  
  def receipt
    Receipts::Receipt.new(
        id: id,
        product: "Store",
        company: {
          name: "Event Searcher Co",
          address: "123 Example Street",
          email: "support@example.com"
        },
        line_items: [
          ["Date", created_at.to_s ],
          ["Account Billed" , user.email ],
          ["Product" , "Store subscription" ],
          ["Amount ($)" , ActionController::Base.helpers.number_to_currency( event.event_price / 100) ],
          ["Card Charged" , "#{card_brand}(*** *** *** #{card_last4})" ]
          ]
          
        
        
      )
  end

end
