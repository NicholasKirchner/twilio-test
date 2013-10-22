class Message < ActiveRecord::Base

  has_many :recipients

  validates :contents, length: { maximum: 140 }, presence: true

  def send_via_sms
    twilio_client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
    self.recipients.each do |recipient|
      twilio_client.account.sms.messages.create(
        from: TWILIO_CONFIG['from'],
        to: recipient.phone_number,
        body: "#{recipient.first_name}, #{contents}")
    end
  end

end
