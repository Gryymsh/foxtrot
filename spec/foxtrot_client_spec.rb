require 'spec_helper'

describe "new foxtrot client" do
  it "creates a new client" do
    client = Foxtrot::Client.new
    client.should be_a Foxtrot::Client
  end
end