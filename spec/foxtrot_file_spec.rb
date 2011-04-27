require 'spec_helper'

describe "open a file" do
  it "returns a file" do
    file = Foxtrot::File.open("//anok.local/video")
    file.should be_a Foxtrot::File
  end
  
end