class TwilioMessage
  def self.get(*args)
    messages_resource.get(*args)
  end

  def self.create(options)
    messages_resource.create({from: default_from_number}.merge(options))
  end

  private

  def self.default_from_number
    'twilio-no_reply-number'
  end

  def self.messages_resource
    @messages_resource ||= twilio_client.account.messages
  end

  def self.twilio_client
    Twilio::REST::Client.new('TWILIO-ACCOUNT-SID', 'TWILIO-AUTH-TOKEN')
  end
end
