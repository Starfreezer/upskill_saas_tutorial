/* global $, Stripe */
//Document ready,

$(document).on('turbolinks:load', function(){
  var theForm =$('#pro_form');
  var submitBtn =$('#form-submit-btn')
  
  //Set Stripe Public Key,
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  //When user clicks form submit btn,
  submitBtn.click(function(event){
    
    //prevent default submission behavior,
    event.preventDefault();
    
    //Collect the credit card fields,
    var ccNum =$('#card_number').val(),
        cvcNum =$('#card_code').val(),
        expMonth =$('#card_month').val(),
        expYear =$('#card_year').val();
    
    
    //Send Card information to Stripe
    Stripe.createToken({
      number: ccNum,
      cvc: cvcNum,
      exp_month: expMonth,
      exp_year: expYear
    },stripeResponseHandler);
  });
  
  
  
  //Stripe will return Card Token,
  //Inject Card Token as hidden Field
  //Submit form to our Rails app

});
