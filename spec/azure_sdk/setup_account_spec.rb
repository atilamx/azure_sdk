require 'spec_helper'
require 'tempfile'

describe AzureSdk::SetupAccount do
  before do
    @azure_credential =
      "[Azure-Account]\n\
       appId = \n\
       password = \n\
       tenant = \n"
    @tmp_file = create_tmp_file
  end

  after do
    @tmp_file.unlink
  end

  describe ".included" do
    describe "When the module included and the credentials file does not exist" do
      it "Writes a set of basic credentials" do
        allow(AzureSdk::SetupAccount).to receive(:azure_sdk_path).and_return(File.dirname(@tmp_file.path))
        allow(AzureSdk::SetupAccount).to receive(:load_configuration).and_return(true)
        allow(AzureSdk::SetupAccount).to receive(:azure_sdk_credentials_file_path).and_return(@tmp_file.path)

        module AzureSdk::Test
          include AzureSdk::SetupAccount
        end

        expect(@tmp_file.read).to eq @azure_credential
      end
    end

    describe "When the module is included and the credentials file does exit already " do
      it "Opens the file and loads the credentials" do
        fill_credentials
        allow(AzureSdk::SetupAccount).to receive(:azure_sdk_path).and_return(File.dirname(@tmp_file.path))
        allow(AzureSdk::SetupAccount).to receive(:load_configuration).and_return(true)
        allow(AzureSdk::SetupAccount).to receive(:azure_sdk_credentials_file_path).and_return(@tmp_file.path)

        module AzureSdk::Test
          include AzureSdk::SetupAccount
        end

        expect(@tmp_file.read).to eq @azure_credential
      end
    end
  end

  def create_tmp_file
    Tempfile.new('credentials.conf')
  end

  def fill_credentials
    @tmp_file.write(@azure_credential)
    @tmp_file.rewind
  end
end