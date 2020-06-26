require 'spec_helper'
require 'tempfile'

describe AzureSdk::Config do
  before do
    @conf_file = create_conf_test_file
  end

  after(:each) do
    @conf_file.unlink
  end

  describe "#parse_configuration" do
    it "Opens reads the configuration file" do
      expect(subject).to receive(:extract_keys)
      allow(AzureSdk::Config).to receive(:extract_keys).and_return(true)

      AzureSdk::Config.parse_configuration(@conf_file)
      expect(AzureSdk::Config.instance_variable_get(:@credentials)).to match(content_credentials)
    end
  end

  describe "#extract_keys" do
    describe "When missing the values from credentials" do
      it "Raises an exception" do
        incomplete_c = credentials_with_missing_values
        AzureSdk::Config.instance_variable_set(:@credentials, incomplete_c)

        expect { AzureSdk::Config.extract_keys }.to raise_error(StandardError)
      end
    end

    describe "When missing the keys from credentials" do
      it "Raises an exception" do
        incomplete_c = credentials_with_missing_keys
        AzureSdk::Config.instance_variable_set(:@credentials, incomplete_c)

        expect { AzureSdk::Config.extract_keys }.to raise_error(StandardError)
      end
    end

    describe "When values and keys are correct" do
      it "Does not Raises an exception" do
        complete_c = content_credentials.split("\n").pop
        AzureSdk::Config.instance_variable_set(:@credentials, complete_c)

        expect { AzureSdk::Config.extract_keys }.not_to raise_error
      end

      it "Populates the attributes with the values from the credentials file" do
        AzureSdk::Config.instance_variable_set(:@credentials, content_credentials)

        AzureSdk::Config.extract_keys
        expect(AzureSdk::Config.appId).to eq "111111-1111-1111-1111-111111111"
        expect(AzureSdk::Config.password).to eq "111111111111-111111111"
        expect(AzureSdk::Config.tenant).to eq "1111111-11111-11111-11111-1111111"
      end
    end
  end

  def create_conf_test_file
    file = Tempfile.new('credentials.cnf')
    content = content_credentials

    file.write(content)
    file.rewind
    file
  end

  def credentials_with_missing_values
    "[Azure-Account]\n \
      111111-1111-1111-1111-111111111\n \
      111111111111-111111111\n \
      1111111-11111-11111-11111-1111111\n"
  end

  def credentials_with_missing_keys
    "[Azure-Account]\n \
      appId = \n \
      password = \n \
      tenant = \n"
  end

  def content_credentials
    "[Azure-Account]\n \
      appId = 111111-1111-1111-1111-111111111\n \
      password = 111111111111-111111111\n \
      tenant = 1111111-11111-11111-11111-1111111\n"
  end
end