require 'fileutils'
require 'azure_sdk/config'

module AzureSdk
  module SetupAccount
    def self.included(base)
      create_sdk_folder
      create_credentials_file
      load_configuration
    end

    private

    def self.create_sdk_folder
      azure_sdk = azure_sdk_path
      Dir.mkdir(azure_sdk) unless Dir.exist?(azure_sdk)
    end

    def self.create_credentials_file
      conf_file = azure_sdk_credentials_file_path
      keys = "[Azure-Account]\n \
      appId = \n \
      password = \n \
      tenant = \n"

      if File.exists?(conf_file) && !File.empty?(conf_file)
        @file = File.open(conf_file)
      else
        File.write(conf_file, keys)
        STDERR.puts "The credentials file was created please add the correct values" and exit(1)
      end
    end

    def self.load_configuration
      AzureSdk::Config.parse_configuration(@file)
    end

    def self.azure_sdk_path
      File.join(Dir.home,".azure_sdk")
    end

    def self.azure_sdk_credentials_file_path
      File.join(azure_sdk_path,"credentials.cnf")
    end
  end
end
