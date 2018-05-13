$(document).on("turbolinks:load",function(){

  stripe_public_key = $("meta[name='stripe-public-key']").attr("content"); //grab a public key from the <head> tag of HTML
  Stripe.setPublishableKey(stripe_public_key); // initialize Stripe JS library

  var $form = $('#payment-form');// the form on views/attends/new.html.erb
  $form.submit(function(event) { //formのsubmit前に処理を行う（return false;としているのでここでは実際にPOSTはされず、
    //コールバック関数であるstripeResponseHandler内にてPOSTされる）
    // Disable the submit button to prevent repeated clicks:
    $form.find('.submit').prop('disabled', true);

    // Request a token from Stripe:
    Stripe.card.createToken($form, stripeResponseHandler); //createTokenが完了したらstripeResponseHandlerが実行される
    //↑ createToken() create a token from the data in the form and send it to the Stripe server
    //↑ stripeResponseHandler is a callback you provide to handle the response from Stripe. 

    // Prevent the form from being submitted:
    return false;
  });
  
  // $(".show-card-form").on("click", function(e){
  //   e.preventDefault();
  //   $("#existing-card").hide();
  //   $form.show();
  // });
  
});

function stripeResponseHandler(status, response) {//status, responseはcreateTokenによってセットされる
  
  // Grab the form:
  var $form = $('#payment-form');

  if (response.error) { // Problem!

    // Show the errors on the form:
    $form.find('.payment-errors').text(response.error.message);
    $form.find('.submit').prop('disabled', false); // Re-enable submission

  } else { // Token was created!

    // Get the token ID:
    var token = response.id;
    console.log(response);

    // Insert the token ID into the form so it gets submitted to the server:
    $form.append($('<input type="hidden" name="stripeToken">').val(token));
    $form.append($('<input type="hidden" name="card_brand">').val(response.card.brand));
    $form.append($('<input type="hidden" name="card_exp_month">').val(response.card.exp_month));
    $form.append($('<input type="hidden" name="card_exp_year">').val(response.card.exp_year));
    $form.append($('<input type="hidden" name="card_last4">').val(response.card.last4));
    
    // Submit the form:
    $form.get(0).submit(); //temporarily disabled
  }
};
