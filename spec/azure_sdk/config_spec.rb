require 'spec_helper'

describe AzureSdk::Config do
  describe ".test" do
    it "is a basic test" do
      value = AzureSdk::Config.basic_test
      expect(value).to be 5
    end
  end
end