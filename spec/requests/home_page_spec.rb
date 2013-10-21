require 'spec_helper'

describe "Home page" do
  before { visit root_path }

  subject { page }

  it { should have_title("TwilioTest Homepage") }
  it { should have_field("message[contents]") }
  it { should have_field("message[csv_file]", :type => "file") }
end

describe "Message sending" do
  before { visit root_path }

  subject { page }

  describe "with empty message" do
    before { attach_file 'message[csv_file]', Rails.root.join('spec/fixtures/files/good.csv') }

    it "should not create any messages in the database" do
      expect { click_button "Fire Away!" }.not_to change(Message, :count)
    end

    it "should not create any recipients in the database" do
      expect { click_button "Fire Away!" }.not_to change(Recipient, :count)
    end

    it "should refresh the homepage with an error" do
      click_button "Fire Away"
      page.should have_title("TwilioTest Homepage")
      page.should have_selector('h2', text: "Errors")
    end
  end

  describe "with empty file field" do
      before { fill_in 'message[contents]', :with => "Hello, there!" }

    it "should not create any messages in the database" do
      expect { click_button "Fire Away!" }.not_to change(Message, :count)      
    end

    it "should not create any recipients in the database" do
      expect { click_button "Fire Away!" }.not_to change(Recipient, :count)
    end

    it "should refresh the homepage with an error" do
      click_button "Fire Away"
      page.should have_title("TwilioTest Homepage")
      page.should have_selector('h2', text: "Errors")
    end

  end

  describe "with message and file filled in" do
    before { fill_in 'message[contents]', :with => "Hello, there!" }

    describe "with error-free file" do
      before { attach_file 'message[csv_file]', Rails.root.join('spec/fixtures/files/good.csv') }
      it "should create a message in the database" do
        expect { click_button "Fire Away!" }.to change(Message, :count).by(1)
      end

      it "should create recipients in the database" do
        expect { click_button "Fire Away!" }.to change(Recipient, :count).by(2)
      end

      it "should refresh the homepage with a success" do
        click_button "Fire Away"
        page.should have_title("TwilioTest Homepage")
        page.should have_selector('h2', text: "Success")
      end

    end

    describe "with errors in file" do
      before { attach_file 'message[csv_file]', Rails.root.join('spec/fixtures/files/bad.csv') }

      it "should create recipients of the good lines" do
        expect { click_button "Fire Away" }.to change(Recipient, :count).by(1)
      end

      it "should refresh the homepage with an error and success" do
        click_button "Fire Away"
        page.should have_title("TwilioTest Homepage")
        page.should have_selector('h2', text: "Errors")
        page.should have_selector('h2', text: "Success")
      end

    end
  end

end
