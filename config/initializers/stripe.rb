Rails.configuration.stripe = {
  :publishable_key => 'pk_test_4SrYDE7su4cUkSzf2D4C4rsd',
  :secret_key      => 'sk_test_gQA22lCilGbGeSecaXbRNq5L'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]