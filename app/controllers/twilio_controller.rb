class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def sms
    response = Faraday.get("https://quotes.rest/qod?language=en") do |req|
      req.headers.merge!(headers)
    end
    quote = JSON.parse(response.body)["contents"]["quotes"][0]["quote"]

    client = Twilio::REST::Client.new
    client.messages.create(
      from: ENV['TWILIO_PHONE_NO'],
      to: ENV['TWILIO_ACCOUNT_PHONE_NO'],
      body: quote,
    )
  end

  private

  def headers
    {
      "X-TheySaidSo-Api-Secret": "X-TheySaidSo-Api-Secret",
    }
  end
end
