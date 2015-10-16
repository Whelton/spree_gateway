class Spree::Gateway::CheckoutV2Gateway < Spree::Gateway

  preference :secret_key, :string
  preference :publishable_key, :string
  preference :use_card_tokenisation, :boolean, default: true

  def method_type
    'checkout_v2'
  end

  def provider_class
    ActiveMerchant::Billing::CheckoutV2
  end

  def payment_profiles_supported?
    self.preferred_use_card_tokenisation
  end

  def create_profile(payment)
    return nil
  end

  def authorize(money, creditcard, gateway_options)
    if creditcard.number.blank? && creditcard.gateway_payment_profile_id.present?
      provider.authorize(money, creditcard.gateway_payment_profile_id, gateway_options)
    else
      provider.authorize(money, creditcard, gateway_options)
    end
  end

end
