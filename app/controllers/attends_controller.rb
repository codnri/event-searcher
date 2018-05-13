class AttendsController < ApplicationController
  
  
  def index
    @attends = current_user.attends
    @events = Event.where(id: @attends.select(:event_id))
  end
  
  def create
    #@attend =  current_user.events.new(event_params)

    #attends/new.html.erbのフォームがクリックされた後、subscriptions.jsによって処理され、Stripeサーバから結果を受け取った後にcreateのpathにPOSTされてくる
    # chech whether current_user is an existing customer or not, 
    #then get stripe's customer (an instance of Stripe::Customer )
    customer = current_user.stripe_customer(params[:stripeToken])
    
    @attend = current_user.attends.new()
    @attend.event_id = params[:event_id]
    p "^--------"
    p @attend
    
    unless @attend.valid?
      flash.alert = "this attend is invalid"
      redirect_to root_path
    end
    description = "purchased by "+ current_user.email + " at " + Time.now.strftime("%a %b %d %H:%M:%S %z %Y")
    begin
    
    
      Stripe::Charge.create(
        customer: customer, #stripeTokenはStripeサーバから返されるレスポンストークン
        currency: 'cad',
        description: description,
        amount: @attend.event.event_price,
        #customer: customer
        #plan: params[:plan]
      )
    
      #単発の決済
      # Stripe::Charge.create(
      #   source: params[:stripeToken], #stripeTokenはStripeサーバから返されるレスポンストークン
      #   currency: 'cad',
      #   description: description,
      #   amount: @attend.event.event_price,
      # )
      #current_user.assign_attributes(stripe_subscription_id: subscription.id, expires_at: nil)
      current_user.assign_attributes(
          card_brand: params[:card_brand],
          card_last4: params[:card_last4],
          card_exp_month: params[:card_exp_month],
          card_exp_year: params[:card_exp_year]
        ) if params[:card_last4]
      
      current_user.save
      @attend.save
      
      flash.notice = "Thanks for purchasing"
      redirect_to event_path(@attend.event_id)   
    rescue Stripe::CardError => e
      flash.alert =e.message
      render action: :new
    end 

  end
  
  def new
    @attend = current_user.attends.new
    @attend.event_id = params[:event_id]
  end
  
  def show
    #export a PDF file of invoice
    # respond_to do |format|
    #   format.pdf {
    #     send_data(@charge.receipt.render ,
    #               filename: "#{@charge.id}-store-receipt.pdf",
    #               type: "application/pdf",
    #               disposition: :attachment # :inline -> You can open the pdf withing browser
    #               )
    #   }
    # end
  end
  def destroy
  end
  
  private
    def attend_params
      params.require(:attend).permit(:id, :event_id, :user_id)
    end
end
