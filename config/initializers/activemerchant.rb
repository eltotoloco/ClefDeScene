if Rails.env == "development"
  ActiveMerchant::Billing::FirstdataE4Gateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
  ActiveMerchant::Billing::FirstdataE4Gateway.wiredump_device.sync = true
  ActiveMerchant::Billing::Base.mode = :test

  login = "ME7242-86"
  password="uQn4fQAv84uNOt2ttSHYfFTD6gnRFQvD"
elsif Rails.env == "production"
  login = 'ME7242-86'
  password='uQn4fQAv84uNOt2ttSHYfFTD6gnRFQvD'
end
GATEWAY = ActiveMerchant::Billing::FirstdataE4Gateway.new({
      login: login,
      password: password
})