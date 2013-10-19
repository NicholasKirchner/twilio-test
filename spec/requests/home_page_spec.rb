require 'spec_helper'

describe "Home page" do
  before { visit root_path }

  subject { page }

  it { should have_field("message[contents]") }
  it { should have_field("message[csv_file]", :type => "file") }
end
