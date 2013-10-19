require 'spec_helper'

describe Message do

  before do
    @message = Message.new(contents: "Hello")
  end

  subject { @message }

  it { should respond_to(:contents) }
  it { should respond_to(:recipients) }
  it { should be_valid }

  describe "When message is too long" do
    before { @message.contents = ";" * 141 }
    it { should_not be_valid }
  end

end
