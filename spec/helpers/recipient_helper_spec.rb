require 'spec_helper'

describe RecipientHelper do

  describe "#recipients_from_csv" do
    it "Should properly parse a good file" do
      result = recipients_from_csv(Rails.root.join('spec/fixtures/files/good.csv'))
      result[:errors].should eq([])
      result[:recipients][0].first_name.should eq("Joey")
      result[:recipients][0].phone_number.should eq("1234567890")
      result[:recipients][1].first_name.should eq("Jo-Jo")
      result[:recipients][1].phone_number.should eq("0987654321")
    end

    it "Should say line numbers which caused an error" do
      result = recipients_from_csv(Rails.root.join('spec/fixtures/files/bad.csv'))
      result[:errors].should eq([1])
    end
  end

end
