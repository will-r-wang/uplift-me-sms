module TwilioHelper
  def respond(message)
    case message[:body]
    when "SUBSCRIBE"
      subscriber = Subscriber.create(phone_number: message[:from])
      return "You have successfully subscribed to uplift me sms"
    when "UNSUBSCRIBE"
      subscriber = Subscriber.find_by(phone_number: message[:from])
      if subscriber
        subscriber.destroy
        return "You have successfully unsubscribed from uplift me sms."
      else
        return "Error: You currently are not subscribed."
      end
    else
      return "Error: Unsupported action. The only valid options are SUBSCRIBE/UNSUBSCRIBE."
    end
  end
end
