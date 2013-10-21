require 'csv'

module RecipientHelper

  def recipients_from_csv(csv_file)
    return_hash = {:errors => [], :recipients => []}
    row_number = 1
    CSV.foreach(csv_file) do |row|
      recipient = Recipient.new(first_name: row[0], phone_number: row[1])
      if recipient.valid?
        return_hash[:recipients] << recipient
      else
        return_hash[:errors] << row_number
      end
      row_number += 1
    end
    return_hash
  end

end
