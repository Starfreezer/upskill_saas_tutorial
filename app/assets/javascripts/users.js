/* global $, Stripe */
//Document ready,

$(document).on('turbolinks:load', function(){
  var theForm =$('#pro_form');
  var submitBtn =$('#form-submit-btn')
  
  //Set Stripe Public Key,
   Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
  //When user clicks form submit btn,
  submitBtn.click(function(event){
    
    //prevent default submission behavior,
    event.preventDefault();
    submitBtn.val("Processing...").prop('disabled', true);
    
    //Collect the credit card fields,
    var ccNum =$('#card_number').val(),
        cvcNum =$('#card_code').val(),
        expMonth =$('#card_month').val(),
        expYear =$('#card_year').val();
        
    //Use stripe js to check for card errors
    var error = false;
    
    //Validate Card Number
    if (!Stripe.card.validateCardNumber(ccNum)) {
      error = true;
      alert('Card Number appears to be invalid')
    }
    //Validate CVC
    if (!Stripe.card.validateCVC(cvcNum)) {
      error = true;
      alert('CVC appears to be invalid')
    }
    //Validate Expiration Date
    if (!Stripe.card.validateExpiry(expMonth, expYear)) {
      error = true;
      alert('The expiration Date appears to be invalid')
    }
      
    
    if(error) {
      //if there are card errors dont send to stripe
      submitBtn.val("Sign Up").prop('disabled', false)
      
    } else {
      
      //Send Card information to Stripe
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
      }, stripeResponseHandler);
    }
    return false;
  });
  
  //Stripe will return Card Token,
   function stripeResponseHandler(status, response) {
    //Get the token from the response.
    var token = response.id;
    //Inject the card token in a hidden field.
    theForm.append( $('<input type="hidden" name="user[stripe_card_token]">').val(token) );
    //Submit form to our Rails app.
    theForm.get(0).submit();
  }
});