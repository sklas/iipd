require 'spec_helper'

describe SearchController do

  describe "GET 'blast'" do
    it "returns http success" do
      get 'blast'
      response.should be_success
    end
  end

  describe "GET 'domains'" do
    it "returns http success" do
      get 'domains'
      response.should be_success
    end
  end

end
