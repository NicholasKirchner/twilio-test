require "spec_helper"

describe Recipient do

  before do
    @recip = Recipient.new(first_name: "Joey", phone_number: "111-111-1111")
  end

  subject { @recip }

  it { should respond_to(:first_name) }
  it { should respond_to(:phone_number) }
  it { should be_valid }
  
  describe "When phone number format is U.S. Standard (ten digits)" do
    it "should be valid" do
      numbers = ["111-111-1111", "1111111111", "(111) 111 1111"]
      numbers.each do |valid_number|
        @recip.phone_number = valid_number
        expect(@recip).to be_valid
      end
    end
  end

  describe "When phone number format is not U.S. Standard (not ten digits)" do
    it "should be invalid" do
      numbers = ["1111-111-1111", "1-800-800-8000"]
      numbers.each do |invalid_number|
        @recip.phone_number = invalid_number
        expect(@recip).not_to be_valid
      end
    end
  end

end
