jQuery(function ($) {

	var show_error, stripeResponseHandler;
	$("#new_demande").submit(function (event) {
		var $form;
		$form = $(this);
		$form.find("input[type=submit]").prop("disabled", true);
		Stripe.card.createToken($form, stripeResponseHandler);
		return false;
	});

	stripeResponseHandler = function (status, response) {
		var $form, token;
		$form = $("#new_demande");
		if (response.error) {
			show_error(response.error.message);
			$form.find("input[type=submit]").prop("disabled", false);
		} else {
			token = response.id;
			var tokenInput = $("<input type=hidden name=stripeToken />").val(response.id);
			var emailInput = $("<input type=hidden name=stripeEmail />").val(response.email);
			$(".new_demande").append(tokenInput).append(emailInput);
			$("[data-stripe=number]").remove();
			$("[data-stripe=cvc]").remove();
			$("[data-stripe=exp-year]").remove();
			$("[data-stripe=exp-month]").remove();
			$form.get(0).submit();
		}
		return false;
	};

	show_error = function (message) {
		$("#flash-messages").html('<div class="alert alert-warning"><a class="close" data-dismiss="alert">×</a><div id="flash_alert">' + message + '</div></div>');
		$('.alert').delay(5000).fadeOut(3000);
		return false;
	};
});


 $(document).ready(function(){
 		$('input.cc-number').payment('formatCardNumber');

 });