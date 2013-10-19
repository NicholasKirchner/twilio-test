class Recipient < ActiveRecord::Base

  belongs_to :message

  before_validation :sanitize_phone
  validates :phone_number, length: { is: 10 }

  private

    def sanitize_phone
      self.phone_number = self.phone_number.gsub(/\D/, "")
    end

end
